resource "azurerm_resource_group" "rg1" {
  name     = var.rg["rg1"].name
  location = var.rg["rg1"].location

  tags = {
    Creator = var.creator
  }
}
module "resource_groups" {
  source = "./modules/resource_groups"

  resource_group_name = resource_groups["rg1"].name
  location            = resource_groups["rg1"].location
  creator             = resource_groups["rg1"].creator
}
