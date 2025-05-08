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

variable "workload_profile_name" {
  description = "Workload profile name"
  type        = string
}
