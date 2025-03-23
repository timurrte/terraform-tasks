resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.rg.location

  tags = {
    Creator = var.creator
  }
}

data "azurerm_key_vault" "kv" {
  name                = local.kv_server_name
  resource_group_name = local.kv_rg_name
}

module "sql" {
  source = "./modules/sql/"
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }

  kv_id = data.azurerm_key_vault.kv.id

  kv = {
    username_secret = var.kv.username_secret
    password_secret = var.kv.password_secret
  }
  sql = {
    server_name    = local.sql_server_name
    db_name        = local.sql_db_name
    admin_username = local.sql_admin_username
    sku_type       = var.sql.sku_type
  }
  firewall = {
    rule_name  = var.firewall_rule_name
    allowed_ip = var.allowed_ip_address
  }

  creator_name = var.creator
}

module "app" {
  source = "./modules/webapp/"

  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  sql_connection_string = module.sql.sql_connection_string
  app = {
    name           = local.app_name
    dotnet_version = var.app.dotnet_version
  }

  asp = {
    name = local.asp_name
    sku  = var.asp.sku
  }

  creator_name = var.creator
}
