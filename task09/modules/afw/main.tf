data "azurerm_resource_group" "afw" {
  name = var.rg_name
}

resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = data.azurerm_resource_group.afw.name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.fw_address_prefix]
}

data "azurerm_subnet" "aks_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = data.azurerm_resource_group.afw.name
}

resource "azurerm_public_ip" "public" {
  name                = local.pip_name
  location            = data.azurerm_resource_group.afw.location
  resource_group_name = data.azurerm_resource_group.afw.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "afw" {
  name                = local.afw_name
  location            = data.azurerm_resource_group.afw.location
  resource_group_name = data.azurerm_resource_group.afw.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.public.id
  }
}

resource "azurerm_route_table" "route" {
  name                = local.rt_name
  location            = data.azurerm_resource_group.afw.location
  resource_group_name = data.azurerm_resource_group.afw.name

  route {
    name                   = "route-through-afw"
    address_prefix         = var.subnet_address_space
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.afw.ip_configuration[0].private_ip_address
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet_route_table_association" "aks" {
  subnet_id      = data.azurerm_subnet.aks_subnet.id
  route_table_id = azurerm_route_table.route.id
}

resource "azurerm_firewall_application_rule_collection" "app_rule" {
  name                = local.app_rule_name
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = data.azurerm_resource_group.afw.name
  priority            = 100
  action              = "Allow"

  dynamic "rule" {
    for_each = var.app_rules
    content {
      name             = rule.value.name
      source_addresses = rule.value.source_addresses
      protocol {
        type = rule.value.protocol.type
        port = rule.value.protocol.port
      }
      target_fqdns = rule.value.target_fqdns
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "net_rule" {
  name                = local.net_rule_name
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = data.azurerm_resource_group.afw.name
  priority            = 200
  action              = "Allow"

  dynamic "rule" {
    for_each = var.network_rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_ports     = rule.value.destination_ports
      destination_addresses = rule.value.destination_addresses
      protocols             = rule.value.protocols
    }
  }
}

resource "azurerm_firewall_nat_rule_collection" "nat_rule" {
  count               = var.enable_nat_rule ? 1 : 0
  name                = local.nat_rule_name
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = data.azurerm_resource_group.afw.name
  priority            = 300
  action              = "Dnat"

  rule {
    name                  = "dnat-to-aks-lb"
    source_addresses      = ["*"]
    destination_addresses = [azurerm_public_ip.public.ip_address]
    destination_ports     = ["80"]
    protocols             = ["TCP"]

    translated_address = var.aks_lb_ip
    translated_port    = "80"
  }
}
