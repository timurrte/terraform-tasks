variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
}

variable "rg_location" {
  description = "Resource Group location"
  type        = string
}

variable "sas_token" {
  description = "SAS token to access Storage Account container"
  type = string
  sensitive = true
}