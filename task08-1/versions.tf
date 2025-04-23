terraform {
  required_version = ">= 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0, < 4.0.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.1.3"
    }
  }
}

provider "kubectl" {
  host                   = module.aks.config.host
  client_certificate     = module.aks.config.client_certificate
  client_key             = module.aks.config.client_key
  cluster_ca_certificate = module.aks.config.cluster_ca_certificate
  load_config_file       = false
}

provider "azurerm" {
  features {}
}

provider "random" {

}
