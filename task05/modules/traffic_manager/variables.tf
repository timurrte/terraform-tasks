variable "profile_name" {
  type        = string
  description = "Traffic Manager profile name"
}

variable "rg" {
  type        = string
  description = "Resource group"
}

variable "app_services" {
  type        = map(any)
  description = "App Services"
}

variable "routing_method" {
  type        = string
  description = "Routing method for Traffic Manager"
}
variable "creator" {
  type        = string
  description = "Creator"
}
