variable "rg" {
  description = "Resource Group for this resource"
  type = object({
    name     = string
    location = string
  })
}

variable "asp" {
  description = "App Service Plan configuration"
  type = object({
    name = string
    sku  = string
  })
}

variable "app" {
  description = "Configuration for Linux Web Application"
  type = object({
    name           = string
    dotnet_version = string
  })
}

variable "sql_connection_string" {
  description = "SQL server connection string"
  sensitive   = true
  type        = string
}

variable "creator_name" {
  description = "Creator of this resource"
  type        = string
}
