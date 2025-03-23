locals {
  rg_name            = format("%s-%s", var.name_prefix, "rg")     # Resource Group
  sql_server_name    = format("%s-%s", var.name_prefix, "sql")    # SQL Server
  kv_server_name     = format("%s-%s", var.name_prefix, "kv")     # SQL Server
  kv_rg_name         = format("%s-%s", var.name_prefix, "kv-rg")  # SQL Server
  sql_db_name        = format("%s-%s", var.name_prefix, "sql-db") # SQL Database
  asp_name           = format("%s-%s", var.name_prefix, "asp")    # App Service Plan
  app_name           = format("%s-%s", var.name_prefix, "app")    # App Service
  sql_admin_username = "sqladmin"                                 # Admin username
}
