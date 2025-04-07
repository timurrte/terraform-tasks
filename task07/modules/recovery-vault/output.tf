output "recovery_policy_id" {
  description = "Recovery policy ID for VM"
  value       = azurerm_backup_policy_vm.policy_vm.id
}

output "vault_name" {
  description = "Recovery Vault name"
  value       = azurerm_recovery_services_vault.vault.name
}