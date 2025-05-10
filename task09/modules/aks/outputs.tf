output "uami_id" {
  description = "ID for UAMI"
  value       = azurerm_user_assigned_identity.uami.id
}

output "uami_principal" {
  description = "UAMI principal ID"
  value       = azurerm_user_assigned_identity.uami.principal_id
}
