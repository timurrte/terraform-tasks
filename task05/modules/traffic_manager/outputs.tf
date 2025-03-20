output "fqdn" {
  value       = azurerm_traffic_manager_profile.tm_profile.fqdn
  description = "FQDN of Traffic Manager"
}
