variable "creator" {
  type        = string
  description = "Creator of resource"
}

variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  }))
  description = "Map of resource group objects"
}

variable "traf" {
  type = map(object({
    profile_name   = string
    routing_method = string
  }))
  description = "Configuration for Azure Traffic Manager"
}
variable "service_plans" {
  type = map(object({
    rg_key         = string
    name           = string
    instance_count = number
    sku_type       = string
  }))
  description = "Map of Application Service Plans"
}
variable "app_services" {
  type = map(object({
    sp_key = string
    rg_key = string
    name   = string
  }))
  description = "App Services configuration"
}

variable "ip_rules" {
  description = "IP restriction rules"
  type = list(object({
    name        = string
    action      = string
    ip_address  = string
    service_tag = string
  }))
}
