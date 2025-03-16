output "rg_id" {
  value       = azurerm_resource_group.rg01.id
  description = "Azure Resource Group ID"
}

output "sa_blob_endpoint" {
  value       = azurerm_storage_account.st01.primary_blob_endpoint
  description = "Azure Storage Account blob service primary endpoint"
}

output "vnet_id" {
  value       = azurerm_virtual_network.vnet01.id
  description = "VNet ID"
}
