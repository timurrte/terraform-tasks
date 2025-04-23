output "config" {
  description = "Kluster config"
  value       = azurerm_kubernetes_cluster.cluster.kube_config[0]
}

output "kv_access_identity_id" {
  value = azurerm_kubernetes_cluster.cluster.identity[0].principal_id
}

output "lb_ip" {
  description = "Load Balancer IP address of APP in AKS"
  value       = azurerm_kubernetes_cluster.cluster.ip
}