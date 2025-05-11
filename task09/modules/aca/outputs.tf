output "aca_fqdn" {
  value       = azurerm_container_app.example.ingress[0].fqdn
  description = "FQDN of App in Azure Container App"
}
