output "config" {
  description = "Kluster config"
  value       = azurerm_kubernetes_cluster.cluster.kube_config[0]
}

output "kv_access_identity_id" {
  description = "AKS identity id for kv access"
  value       = azurerm_kubernetes_cluster.cluster.identity[0].principal_id
}

output "kubelet_object_id" {
  description = "Kubelet object ID"
  value       = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}
