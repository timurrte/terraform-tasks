variable "vnet_name" {
  description = "Existing Resource Group name to use"
  type        = string
}

variable "existing_rg_name" {
  description = "Existing Resource Group name"
  type        = string
}

variable "name_prefix" {
  description = "Name Prefix"
  type        = string
}

variable "aks_loadbalancer_ip" {
  description = "AKS LB IP"
  type        = string
}
variable "subnet_name" {
  description = "Existing subnet name"
  type        = string
}

variable "location" {
  description = "Location of resources"
  type        = string
}
variable "vnet_address_space" {
  description = "Existing VNET address space"
  type        = string
}

variable "subnet_address_space" {
  description = "Existing subnet address space"
  type        = string
}
