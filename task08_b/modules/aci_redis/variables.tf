variable "rg" {
  description = "Resource Group name and location"
  type = object({
    name     = string
    location = string
  })
}

variable "redis_aci_name" {
  description = "Redis ACI name"
  type        = string
}

variable "kv_id" {
  description = "KV ID"
  type        = string
}

variable "sku_type" {
  description = "SKU type"
  type        = string
}

variable "common_tag" {
  description = "Common tag"
  type        = string
}

variable "redis_password_secret_name" {
  description = "Redis password secret name"
  type        = string
}

variable "redis_host_secret_name" {
  description = "Redis hostname secret name"
  type        = string
}
