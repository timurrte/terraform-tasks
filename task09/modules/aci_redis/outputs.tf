output "redis_fqdn" {
  value       = azurerm_container_group.example.fqdn
  description = "FQDN of Redis in Azure Container Instance"
}
