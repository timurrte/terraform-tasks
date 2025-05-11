output "context_url" {
  description = "App archive context URL"
  # value       = "${azurerm_storage_blob.app_archive.url}?${data.azurerm_storage_account_sas.sas.sas}"
  value = azurerm_storage_blob.app_archive.url
}

output "sas_token" {
  description = "SA SAS token"
  value       = data.azurerm_storage_account_sas.sas.sas
}
