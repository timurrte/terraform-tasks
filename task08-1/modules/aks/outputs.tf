output "host" {
  description = "Kluster hostname"
  value       = azurerm_kubernetes_cluster.cluster.hostname
}

output "client_certificate" {
  description = "Client certificate"
  value       = azurerm_kubernetes_cluster.cluster.client_certificate
  sensitive   = true
}

output "client_key" {
  description = "Client key"
  value       = azurerm_kubernetes_cluster.cluster.client_key
  sensitive   = true
}

output "client_ca_certificate" {
  description = "Client CA certificate"
  value       = azurerm_kubernetes_cluster.cluster.client_ca_certificate
  sensitive   = true
}

output "kv_access_identity_id" {
  value = azurerm_kubernetes_cluster.cluster.identity[0].principal_id
}