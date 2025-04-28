terraform {
  required_version = ">= 1.5.7"
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.1.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.36.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0, < 4.0.0"
    }
  }
}

provider "kubectl" {
  host                   = module.aks.config.host
  client_certificate     = base64decode(module.aks.config.client_certificate)
  client_key             = base64decode(module.aks.config.client_key)
  cluster_ca_certificate = base64decode(module.aks.config.cluster_ca_certificate)
  apply_retry_count      = 2
  load_config_file       = false
}

provider "kubernetes" {
  host                   = module.aks.config.host
  client_certificate     = base64decode(module.aks.config.client_certificate)
  client_key             = base64decode(module.aks.config.client_key)
  cluster_ca_certificate = base64decode(module.aks.config.cluster_ca_certificate)
}

provider "azurerm" {
  features {}
}

provider "random" {

}
