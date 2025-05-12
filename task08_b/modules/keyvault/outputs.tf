output "kv_policy" {
  description = "KV access policy"
  value       = azurerm_key_vault_access_policy.example.id
}

output "id" {
  description = "KV ID"
  value       = azurerm_key_vault.kv.id
}
