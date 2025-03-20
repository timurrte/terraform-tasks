resource "azurerm_service_plan" "sp" {
  name                = var.sp_name
  resource_group_name = var.rg.name
  location            = var.rg.location
  os_type             = "Windows"
  sku_name            = var.sku_type
  worker_count        = var.instance_count
  tags = {
    Creator = var.creator
  }
}
