variable "kv_name" {
  description = "Key Vault name"
  type        = string
}

variable "rg" {
  description = "Resource group name and location"
  type = object({
    location = string
    name     = string
  })
}

variable "sku" {
  description = "KV SKU type"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "object_id" {
  description = "Object ID"
  type        = string
}

variable "common_tag" {
  description = "Common tag"
  type        = string
}