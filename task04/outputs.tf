output "vm_public_ip" {
  value       = azurerm_public_ip.publ01.ip_address
  description = "VM Public IP address"
}

output "vm_fqdn" {
  value       = azurerm_virtual_network.vnet01.id
  description = "VM Fully qualified domain name"
}
