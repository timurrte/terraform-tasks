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
variable "creator" {
  type        = string
  description = "Creator tag value"
}
