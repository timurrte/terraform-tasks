resource "azurerm_resource_group" "rg01" {
  name     = var.resource_group_name
  location = "West Europe"

  tags = {
    Creator = var.creator
  }
}

resource "azurerm_virtual_network" "vnet01" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  address_space       = ["10.10.0.0/16"]

  tags = {
    Creator = var.creator
  }
}

resource "azurerm_subnet" "subnet01" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg01.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_public_ip" "publ01" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  allocation_method   = "Static"
  domain_name_label   = var.dns_label_name

  tags = {
    Creator = var.creator
  }
}

resource "azurerm_network_interface" "nic01" {
  name                = var.nic_name
  location            = azurerm_resource_group.rg01.location
  resource_group_name = azurerm_resource_group.rg01.name

  ip_configuration {
    name                          = var.nic_name
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publ01.id
  }

  tags = {
    Creator = var.creator
  }
}

resource "azurerm_network_security_group" "nsg01" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg01.location
  resource_group_name = azurerm_resource_group.rg01.name

  tags = {
    Creator = var.creator
  }
}

resource "azurerm_network_security_rule" "nsr_http_01" {
  name                        = var.nsr_http
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg01.name
  network_security_group_name = azurerm_network_security_group.nsg01.name
}

resource "azurerm_network_security_rule" "nsr_ssh_01" {
  name                        = var.nsr_ssh
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg01.name
  network_security_group_name = azurerm_network_security_group.nsg01.name
}

resource "azurerm_network_interface_security_group_association" "nic_sg_assoc01" {
  network_interface_id      = azurerm_network_interface.nic01.id
  network_security_group_id = azurerm_network_security_group.nsg01.id
}

resource "azurerm_linux_virtual_machine" "vm01" {
  name                            = var.vm_name
  resource_group_name             = azurerm_resource_group.rg01.name
  location                        = azurerm_resource_group.rg01.location
  size                            = var.vm_size
  admin_username                  = "adminuser"
  admin_password                  = var.vm_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic01.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = var.vm_os
    sku       = var.vm_sku
    version   = "latest"
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = var.vm_admin_user
      password = var.vm_password
      host     = azurerm_public_ip.publ01.ip_address
    }

    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }

  tags = {
    Creator = var.creator
  }
}
