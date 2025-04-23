output "acr_login_server" {
  description = "URL used to log in into container registry"
  value       = azurerm_container_registry.acr.login_server
}