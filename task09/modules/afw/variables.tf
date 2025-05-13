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

variable "vnet_address_space" {
  description = "Existing VNET address space"
  type        = string
}

variable "subnet_address_space" {
  description = "Existing subnet address space"
  type        = string
}

variable "app_rules" {
  description = "List of App rules"
  type = list(object({
    name             = string
    source_addresses = list(string)
    protocol = object({
      type = string
      port = string
    })
    target_fqdns = list(string)
  }))
}

variable "enable_nat_rule" {
  description = "Enable NAT rule"
  type        = bool
  default     = true
}
variable "network_rules" {
  description = "List of Network rules"
  type = list(object({
    name                  = string
    source_addresses      = list(string)
    destination_ports     = list(string)
    destination_addresses = list(string)
    protocols             = list(string)
  }))
}
