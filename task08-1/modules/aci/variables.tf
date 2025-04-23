variable "aci_name" {
  description = "Container Instance name"
  type        = string
}

variable "aci_sku" {
  description = "ACI SKU type"
  type        = string
}

variable "name_prefix" {
  description = "Name Prefix for DNS"
  type        = string
}

variable "rg" {
  description = "Resource Group name and location"
  type = object({
    name     = string
    location = string
  })
}

variable "acr_login_server" {
  description = "ACR login server URL"
  type        = string
}

variable "image_name" {
  description = "Container Image name"
  type        = string
}

variable "image_tag" {
  description = "Image tag"
  type        = string
}

variable "kv_id" {
  description = "Key Vault ID"
  type        = string
}

variable "common_tag" {
  description = "Common tag"
  type        = string
}

variable "redis_host_secret_name" {
  description = "Redis hostname secret name"
  type        = string
}

variable "redis_pak_secret_name" {
  description = "Redis PAK secret name"
  type        = string
}