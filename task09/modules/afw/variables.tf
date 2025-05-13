variable "rg_name" {
  description = "Existing Resource Group name to put resources in"
  type        = string
}

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

variable "fw_address_prefix" {
  description = "Firewall address prefix"
  type        = string
  default     = "10.0.1.0/24"
}
