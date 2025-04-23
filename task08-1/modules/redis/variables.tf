variable "rg" {
  description = "Resource Group name and location"
  type = object({
    name     = string
    location = string
  })
}

variable "redis_name" {
  description = "Name for Redis instance"
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

variable "redis_pak_secret_name" {
  description = "Redis PAK secret name"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Redis hostname secret name"
  type        = string
}

variable "capacity" {
  description = "Redis cache capacity"
  type        = string
}

variable "sku" {
  description = "Redis SKU"
  type        = string
}

variable "sku_family" {
  description = "Redis SKU family"
  type        = string
}