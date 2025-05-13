output "afw_public_ip" {
  description = "AFW public IP"
  value       = azurerm_public_ip.public.ip_address
}

output "afw_private_ip" {
  description = "AFW private IP"
  value       = azurerm_firewall.afw.ip_configuration.private_ip_address
}
