output "aca_fqdn" {
  # value       = azurerm_container_app.example.ingress[0].fqdn
  value       = azurerm_container_app.example.latest_revision_fqdn
  description = "FQDN of App in Azure Container App"
}
