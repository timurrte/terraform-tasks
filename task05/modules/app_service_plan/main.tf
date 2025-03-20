resource "azurerm_service_plan" "sp" {
  name                = var.sp_name
  resource_group_name = var.rg.name
  location            = var.rg.location
  os_type             = "Windows"
  sku_name            = var.sku_type

  tags = {
    Creator = var.creator
  }
}
