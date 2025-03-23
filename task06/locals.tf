locals {
  rg_name            = format("%s-%s", var.name_prefix, var.rg.name)         # Resource Group
  sql_server_name    = format("%s-%s", var.name_prefix, var.sql.server_name) # SQL Server
  sql_db_name        = format("%s-%s", var.name_prefix, var.sql.db_name)     # SQL Database
  asp_name           = format("%s-%s", var.name_prefix, var.asp.name)        # App Service Plan
  app_name           = format("%s-%s", var.name_prefix, var.app.name)        # App Service
  sql_admin_username = "sqladmin"                                            # Admin username
}
