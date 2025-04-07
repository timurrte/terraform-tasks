resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.rg_location
}

module "cdn" {
  source = "./modules/cdn"
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  cdn_endpoint_name = "module7-vm-files-endpoint"
  cdn_origin = "module7sa.blob.core.windows.net"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vm-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "sub1" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

module "linux_vm" {
  source = "./modules/vm"

  subnet_id = azurerm_subnet.sub1.id

  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }

  storage_account_name = "module7sa"
  container_name = "vm-files"

  sas_token = var.sas_token
}

module "recovery-vault" {
  source = "./modules/recovery-vault"

  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
}

resource "azurerm_backup_protected_vm" "name" {
  resource_group_name = azurerm_resource_group.rg.name
  recovery_vault_name = module.recovery-vault.vault_name
  source_vm_id        = module.linux_vm.vm_id
  backup_policy_id    = module.recovery-vault.recovery_policy_id
}