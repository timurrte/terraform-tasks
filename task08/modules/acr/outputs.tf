output "acr_login_server" {
  description = "URL used to log in into container registry"
  value       = azurerm_container_registry.acr.login_server
}

output "id" {
  description = "ACR ID"
  value       = azurerm_container_registry.acr.id
}

output "login_server" {
  description = "ACR login server"
  value       = azurerm_container_registry.acr.login_server
}

output "admin_username" {
  description = "ACR admin username"
  value       = azurerm_container_registry.acr.admin_username
}
output "admin_password" {
  description = "ACR admin password"
  value       = azurerm_container_registry.acr.admin_password
}
