resource "azurerm_storage_account" "sa1" {
  name                     = "module7sa"
  resource_group_name      = local.rg_name
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}