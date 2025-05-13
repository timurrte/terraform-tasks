resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
}

module "afw" {
  source = "./modules/afw/"

  rg_name     = azurerm_resource_group.rg.name
  vnet_name   = var.vnet_name
  name_prefix = var.name_prefix
  aks_lb_ip   = var.aks_lb_ip
  subnet_name = var.subnet_name
}
