output "sql_connection_string" {
  description = "SQL connection string"
  value = sensitive(format(
    "Server=tcp:%s.database.windows.net,1433;Initial Catalog=%s;User ID=%s;Password=%s;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
    azurerm_mssql_server.sql_server.name,
    azurerm_mssql_database.db.name,
    var.admin_username,
    random_password.sql_admin_password.result
  ))
}
