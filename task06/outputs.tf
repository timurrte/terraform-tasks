output "app_hostname" {
  description = "Linux Web App hostname"
  value       = module.app.app_hostname
}

output "sql_server_fqdn" {
  description = "SQL server fully qualified domain name"
  value       = module.sql.sql_server_fqdn
}
