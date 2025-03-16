output "rg_id" {
value = azurerm_resource_group.rg01.id
}

output "sa_blob_endpoint" {
  value = azurerm_storage_account.st01.primary_blob_endpoint
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet01.id
}
