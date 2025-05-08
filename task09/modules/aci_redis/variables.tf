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
