variable "profile_name" {
  type        = string
  description = "Traffic Manager profile name"
}

variable "rg" {
  type        = map(any)
  description = "Resource group"
}

variable "app_services" {
  type        = map(any)
  description = "App Services"
}

variable "creator" {
  type        = string
  description = "Creator"
}
