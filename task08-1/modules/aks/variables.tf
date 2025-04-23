variable "rg" {
  description = "Resource Group name and location"
  type = object({
    name     = string
    location = string
  })
}
variable "acr_id" {
  description = "Azure Container Registry ID to pull container images from"
  type        = string
}

variable "k8s_cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID"
  type        = string
}

variable "k8s_node_os_disk_type" {
  description = "AKS node os disk type"
  type        = string
}

variable "k8s_cluster_name" {
  description = "AKS cluster name"
  type        = string
}

variable "k8s_node_count" {
  description = "AKS node count"
  type        = number
}

variable "k8s_node_pool_name" {
  description = "AKS node pool name"
  type        = string
}

variable "k8s_node_size" {
  description = "AKS node size"
  type        = string
}

variable "common_tag" {
  description = "Common tag"
  type        = string
}
