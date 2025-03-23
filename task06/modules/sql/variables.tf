variable "rg" {
  description = "Resource Group for this module"
  type = object({
    name     = string
    location = string
  })
}

variable "kv" {
  description = "Key Vault options"
  type = object({
    name            = string
    tenant_id       = string
    username_secret = string
    password_secret = string
  })
}

variable "sql" {
  description = "SQL server and database options"
  type = object({
    server_name    = string
    db_name        = string
    admin_username = string
    sku_type       = string
  })
}

variable "firewall" {
  description = "SQL firewall settings"
  type = object({
    rule_name  = string
    allowed_ip = string
  })
}

variable "creator_name" {
  description = "Creator of this resource"
  type        = string
}
