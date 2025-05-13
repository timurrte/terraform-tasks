module "afw" {
  source = "./modules/afw/"

  rg_name              = var.existing_rg_name
  vnet_name            = var.vnet_name
  vnet_address_space   = var.vnet_address_space
  name_prefix          = var.name_prefix
  aks_lb_ip            = var.aks_lb_ip
  subnet_name          = var.subnet_name
  subnet_address_space = var.subnet_address_space
}
