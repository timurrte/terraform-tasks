output "id" {
  description = "ACR ID"
  value       = azurerm_container_registry.acr.id
}

output "login_server" {
  description = "ACR login server"
  value       = azurerm_container_registry.acr.login_server
}
