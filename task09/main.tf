module "afw" {
  source = "./modules/afw/"

  rg_name              = var.existing_rg_name
  vnet_name            = var.vnet_name
  vnet_address_space   = var.vnet_address_space
  name_prefix          = var.name_prefix
  aks_lb_ip            = var.aks_loadbalancer_ip
  subnet_name          = var.subnet_name
  subnet_address_space = var.subnet_address_space

  app_rules = [
    {
      name             = "AllowWeb"
      source_addresses = ["10.0.0.0/24"]
      protocol = {
        type = "Http"
        port = 80
      }
      target_fqdns = ["www.microsoft.com"]
    }
  ]
  network_rules = [
    {
      name                  = "AllowDNS"
      source_addresses      = ["10.0.0.0/24"]
      destination_ports     = ["53"]
      destination_addresses = ["*"]
      protocols             = ["UDP", "TCP"]
    }
  ]
}
