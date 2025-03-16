resource "azurerm_resource_group" "rg01" {
  name     = "cmaz-a36a106e-mod3-rg"
  location = "West Europe"

  tags = {
    Creator = "tymur_nikolaiev@epam.com"
  }
}

resource "azurerm_storage_account" "st01" {
  name                     = "cmaza36a106esa"
  resource_group_name      = azurerm_resource_group.rg01.name
  location                 = azurerm_resource_group.rg01.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Creator = "tymur_nikolaiev@epam.com"
  }
}

resource "azurerm_virtual_network" "vnet01" {
  name                = "cmaz-a36a106e-mod3-vnet"
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  address_space       = ["10.10.0.0/16"]

  tags = {
    Creator = "tymur_nikolaiev@epam.com"
  }
}

resource "azurerm_subnet" "subnet01" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.rg01.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_subnet" "subnet02" {
  name                 = "backend"
  resource_group_name  = azurerm_resource_group.rg01.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.10.2.0/24"]
}
