resource "azurerm_resource_group" "rg01" {
  name     = var.resource_group_name
  location = "West Europe"

  tags = {
    Creator = var.creator
  }
}

resource "azurerm_storage_account" "st01" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg01.name
  location                 = azurerm_resource_group.rg01.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Creator = var.creator
  }
}

resource "azurerm_virtual_network" "vnet01" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  address_space       = ["10.10.0.0/16"]

  tags = {
    Creator = var.creator
  }
}

resource "azurerm_subnet" "subnet01" {
  name                 = var.subnet_front
  resource_group_name  = azurerm_resource_group.rg01.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_subnet" "subnet02" {
  name                 = var.subnet_back
  resource_group_name  = azurerm_resource_group.rg01.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.10.2.0/24"]
}
