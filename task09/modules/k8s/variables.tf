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
variable "tenant_id" {
  description = "Tenant ID"
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
