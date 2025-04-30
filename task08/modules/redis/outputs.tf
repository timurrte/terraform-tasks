output "pak" {
  description = "Redis PAK name"
  value       = azurerm_key_vault_secret.pak
}

output "host" {
  description = "Redis host secret name"
  value       = azurerm_key_vault_secret.hostname
}
