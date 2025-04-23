variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "storage_account_name" {
  type        = string
  description = "Storage Account name"
}

variable "vnet_name" {
  type        = string
  description = "VNet name"
}

variable "subnet_front" {
  type        = string
  description = "Subnet for fronted"
}

variable "subnet_back" {
  type        = string
  description = "Subnet for backend"
}

variable "creator" {
  type        = string
  description = "Creator of project"
}
