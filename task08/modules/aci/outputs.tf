output "fqdn" {
  description = "FQDN of container group"
  value = azurerm_container_group.example.fqdn
}