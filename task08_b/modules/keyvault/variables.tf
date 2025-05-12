variable "kv_name" {
  description = "KeyVault name"
  type        = string
}
variable "rg" {
  description = "Resource Group name and location"
  type = object({
    name     = string
    location = string
  })
}

variable "kv_sku" {
  description = "KV SKU type"
  type        = string
}

variable "common_tag" {
  description = "Common tag"
  type        = string
}
