variable "aks_kv_access_identity_id" {
  description = "AKS KV access identity ID"
  type        = string
}

variable "keyvault_name" {
  description = "KeyVault name"
  type        = string
}

variable "redis_host_secret_name" {
  description = "Redis Hostname secret name"
  type        = string
}
variable "redis_pak_secret_name" {
  description = "Redis PAT secret name"
  type        = string
}

variable "kv_id" {
  description = "KeyVault ID"
  type        = string
}
variable "acr_login_server" {
  description = "ACR login server hostname"
  type        = string
}
variable "app_image_name" {
  description = "App image name"
  type        = string
}
variable "aks_config" {
  description = "Kubectl provider config"
  type = object({
    host                   = string
    client_certificate     = string
    client_key             = string
    cluster_ca_certificate = string
  })
}
