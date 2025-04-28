variable "rg" {
  description = "Resource Group name and location"
  type = object({
    name     = string
    location = string
  })
}

variable "tenant_id" {

  description = "Tenant ID"
  type        = string
}
variable "acr_id" {
  description = "Azure Container Registry ID to pull container images from"
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID"
  type        = string
}

variable "sp" {
  description = "Service Principal ID and secret"
  type = object({
    client_id     = string
    client_secret = string
  })
}

variable "k8s" {
  description = "Kubernetes cluster config"
  type = object({
    cluster_name      = string
    node_os_disk_type = string
    node_count        = number
    node_pool_name    = string
    node_size         = string
  })
}

variable "common_tag" {
  description = "Common tag"
  type        = string
}

variable "name_prefix" {
  description = "Name prefix"
  type        = string
}
