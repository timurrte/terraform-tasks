variable "rg_location" {
  description = "Resource Group location"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for names"
  type        = string
}

variable "git_pat" {
  description = "Git Personal Access token"
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

variable "redis" {
  description = "Redis module config"
  type = object({
    capacity   = string
    sku        = string
    sku_family = string
  })
}

variable "image_name" {
  description = "Image name"
  type        = string
}

variable "common_tag" {
  description = "Common tag for all resources"
  type        = string
}

variable "aci_sku" {
  description = "ACI SKU type"
  type        = string
}