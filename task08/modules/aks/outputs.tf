output "config" {
  description = "Kluster config"
  value       = azurerm_kubernetes_cluster.cluster.kube_config[0]
}

output "kubelet_object_id" {
  description = "Kubelet object ID"
  value       = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}
