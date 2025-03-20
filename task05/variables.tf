variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  }))
  description = "Map of resource group objects"
}

variable "service_plans" {
  type = map(object({
    name     = string
    sku_type = string
  }))
  description = "Map of Application Service Plans"
}

variables "app_services" {
  type = map(object({
    name                  = string
    ip_restr_rule_name    = string
    allowed_ip            = string
    allowed_tag_rule_name = string
    allowed_tag           = string
  }))
}
