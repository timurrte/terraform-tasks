output "app_hostname" {
  description = "Linux web app hostname"
  value       = azurerm_linux_web_app.app.default_hostname
}
