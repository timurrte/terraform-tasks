resource "azurerm_recovery_services_vault" "vault" {
  name                = "module7-recovery-vault"
  location            = var.rg.location
  resource_group_name = var.rg.name
  sku                 = "Standard"

  soft_delete_enabled = true
}

resource "azurerm_backup_policy_vm" "policy_vm" {
  name                = "module7-vm-recovery-vault-policy"
  resource_group_name = var.rg.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }
  retention_daily {
    count = 7
  }
}

