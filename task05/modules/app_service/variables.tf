variable "app_name" {
  type        = string
  description = "Service Plan name"
}

variable "ip_restriction_rule_name" {
  type        = string
  description = "IP restriction rule name"
}

variable "allowed_ip" {
  type        = string
  description = "Allowed IP"
}

variable "allow_tag_rule_name" {
  type        = string
  description = "Allowed service tag name"
}

variable "allowed_tag" {
  type        = string
  description = "Allowed service tag"
}

variable "rg" {
  type        = map(any)
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
