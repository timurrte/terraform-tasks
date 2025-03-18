variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "vnet_name" {
  type        = string
  description = "VNet name"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
}

variable "public_ip_name" {
  type        = string
  description = "Public IP name"
}

variable "nic_name" {
  type        = string
  description = "Network Interface name"
}

variable "nsg_name" {
  type        = string
  description = "Network Security Group name"
}

variable "nsr_http" {
  type        = string
  description = "HTTP Network Security Rule name"
}

variable "nsr_ssh" {
  type        = string
  description = "SSH Network Security Rule name"
}

variable "dns_label_name" {
  type        = string
  description = "DNS label name"
}

variable "vm_name" {
  type        = string
  description = "VM name"
}

variable "creator" {
  type        = string
  description = "Creator of project"
}

variable "vm_size" {
  type        = string
  description = "VM size"
}

variable "vm_password" {
  type        = string
  description = "VM password"
  sensitive   = true
}

variable "vm_os" {
  type        = string
  description = "VM image name"
}

variable "vm_sku" {
  type        = string
  description = "VM SKU"
}
