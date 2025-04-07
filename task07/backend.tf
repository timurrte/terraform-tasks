terraform {
    backend "azurerm" {
        storage_account_name = "sa_name"
        container_name = "value"
        key = "terraform.tfstate"
        access_key = "value"
    }
}