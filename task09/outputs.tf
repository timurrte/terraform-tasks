output "azure_firewall_public_ip" {
  description = "Firewall Public IP"
  value       = module.afw.afw_public_ip
}

output "azure_firewall_private_ip" {
  description = "Firewall Private IP"
  value       = module.afw.afw_private_ip
}
