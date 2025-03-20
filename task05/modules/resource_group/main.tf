resource "azurerm_resource_group" "rg1" {
  name     = var.resource_group.name
  location = var.resource_group.location

  tags = {
    Creator = var.creator
  }
}
