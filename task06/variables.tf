variable "name_prefix" {
  description = "Prefix for all Azure resource names"
  type        = string
}

variable "rg" {
  description = "Resource Group name and location"
  type = object({
    name     = string
    location = string
  })
}

variable "kv" {
  description = "Key Vault connection configuration for storing secrets"
  type = object({
    username_secret = string
    password_secret = string
  })
}

variable "sql" {
  description = "SQL server and database configuration"
  type = object({
    sku_type = string
  })
}

variable "firewall" {
  description = "Database Firewall rule name and allowed ip"
  type = object({
    rule_name  = string
    allowed_ip = string
  })
}

variable "asp" {
  description = "App Service Plan configuration"
  type = object({
    sku = string
  })
}

variable "app" {
  description = "Linux Web App configuration"
  type = object({
    dotnet_version = string
  })
}

variable "creator" {
  description = "Creator of this resource"
  type        = string
}
