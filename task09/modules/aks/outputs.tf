output "uami_id" {
  description = "ID for UAMI"
  value       = azurerm_user_assigned_identity.uami.id
}

output "uami_principal" {
  description = "UAMI principal ID"
  value       = azurerm_user_assigned_identity.uami.principal_id
}

output "host" {
  description = "K8s cluster host"
  value       = azurerm_kubernetes_cluster.example.fqdn
}

output "config" {
  description = "Kubectl provider config"
  value       = azurerm_kubernetes_cluster.example.kube_config[0]
}
