resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "password" {
  name         = var.kv.password_secret
  value        = random_password.password.result
  key_vault_id = var.kv_id
}

resource "azurerm_key_vault_secret" "username" {
  name         = var.kv.username_secret
  value        = var.sql.admin_username
  key_vault_id = var.kv_id
}

resource "azurerm_mssql_server" "server" {
  name                         = var.sql.server_name
  resource_group_name          = var.rg.name
  location                     = var.rg.location
  version                      = "12.0"
  administrator_login          = var.sql.admin_username
  administrator_login_password = random_password.password.result
  minimum_tls_version          = "1.2"

  tags = {
    Creator = var.creator_name
  }
}

resource "azurerm_mssql_firewall_rule" "rule01" {
  name             = var.firewall.rule_name
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = var.firewall.allowed_ip
  end_ip_address   = var.firewall.allowed_ip
}

resource "azurerm_mssql_firewall_rule" "rule02" {
  name             = "allow-azure"
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = "0.0"
  end_ip_address   = "0.0"
}

resource "azurerm_mssql_database" "db" {
  name        = var.sql.db_name
  server_id   = azurerm_mssql_server.server.id
  max_size_gb = 1
  sku_name    = var.sql.sku_type

  tags = {
    Creator = var.creator_name
  }

}
