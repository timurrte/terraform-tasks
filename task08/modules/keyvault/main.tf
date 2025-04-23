resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  location                    = var.rg.location
  resource_group_name         = var.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = var.sku

  tags = {
    Creator = var.common_tag
  }
}

resource "azurerm_key_vault_access_policy" "kv_policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "Get", "Set", "Delete", "Backup", "Purge", "Recover", "Restore"
  ]
}
