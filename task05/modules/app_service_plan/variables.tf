variable "sp_name" {
  type        = string
  description = "Windows Web App name"
}

variable "rg" {
  type        = map(any)
  description = "Resource group"
}

variable "sku_type" {
  type        = string
  description = "SKU type"
}

variable "instance_count" {
  type        = number
  description = "Worker nodes count"
}

variable "creator" {
  type        = string
  description = "Creator tag value"
}
