variable "app_name" {
  type        = string
  description = "Service Plan name"
}

variable "rg" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group"
}

variable "sp_id" {
  type        = string
  description = "Service Plan ID"
}

variable "creator" {
  type        = string
  description = "Creator tag value"
}
variable "ip_rules" {
  type = list(object({
    name        = string
    action      = string
    ip_address  = string
    service_tag = string
  }))
  description = "Map of IP restriction rules"
}
