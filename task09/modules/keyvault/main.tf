resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  location                    = var.rg.location
  resource_group_name         = var.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = var.kv_sku

}

data "azurerm_client_config" "current" {
}

resource "azurerm_key_vault_access_policy" "example" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id

  object_id = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "Get", "Backup", "List", "Delete", "Purge", "Recover", "Restore", "Set"
  ]
}
