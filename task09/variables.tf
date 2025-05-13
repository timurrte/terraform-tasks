variable "vnet_name" {
  description = "Existing Resource Group name to use"
  type        = string
}

variable "name_prefix" {
  description = "Name Prefix"
  type        = string
}

variable "aks_lb_ip" {
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
