variable "subnet_id" {
  description = "Subnet ID for VM"
  type        = string
}

variable "rg" {
  description = "Resource group name and location for VM"
  type = object({
    name     = string
    location = string
  })
}

variable "storage_account_name" {
  description = "Storage Account name that stores blob container"
  type = string
}

variable "container_name" {
  description = "Blob container name to mount"
  type = string
}

variable "sas_token" {
  description = "SAS token for accessing SA container"
  type = string
  sensitive = true
}