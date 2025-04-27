output "id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.kv.id
  depends_on  = [azurerm_key_vault_access_policy.kv_policy]
}

output "kv_policy" {
  description = "Key Vault Policy"
  value       = azurerm_key_vault_access_policy.kv_policy.id
}
