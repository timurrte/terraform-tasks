terraform {
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.1.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.36.0"
    }
  }
}
provider "kubectl" {
  alias                  = "k8s"
  host                   = var.config.host
  client_certificate     = base64decode(var.config.client_certificate)
  client_key             = base64decode(var.config.client_key)
  cluster_ca_certificate = base64decode(var.config.cluster_ca_certificate)
  apply_retry_count      = 2
  load_config_file       = false
}

provider "kubernetes" {
  alias                  = "aks"
  host                   = var.config.host
  client_certificate     = base64decode(var.config.client_certificate)
  client_key             = base64decode(var.config.client_key)
  cluster_ca_certificate = base64decode(var.config.cluster_ca_certificate)
}
