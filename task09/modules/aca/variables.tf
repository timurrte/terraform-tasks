variable "rg" {
  description = "Resource Group name and location"
  type = object({
    name     = string
    location = string
  })
}

variable "redis_password_name" {
  description = "Redis password secret name"
  type        = string
}

variable "redis_hostname_name" {
  description = "Redis hostname secret name"
  type        = string
}

variable "kv_id" {
  description = "Key Vault ID"
  type        = string
}

variable "aca_name" {
  description = "ACA name"
  type        = string
}

variable "image_name" {
  description = "Image name"
  type        = string
}

variable "uami_id" {
  description = "UAMI ID to assign to app"
  type        = string
}

variable "uami_principal" {
  description = "UAMI principal ID to assign to app"
  type        = string
}

variable "object_id" {
  description = "Object ID"
  type        = string
}

variable "acr_id" {
  description = "ACR ID"
  type        = string
}

variable "acr_login_server" {
  description = "ACR login server hostname"
  type        = string
}

variable "common_tag" {
  description = "Common tag"
  type        = string
}

variable "app_env_name" {
  description = "App Environment name"
  type        = string
}

variable "workload_profile_type" {
  description = "Workload profile type"
  type        = string
}
