output "uami_id" {
  description = "ID for UAMI"
  value       = azurerm_user_assigned_identity.uami.id
}

output "kubelet_identity_id" {
  description = "Kubelet idneitity ID"
  value       = azurerm_user_assigned_identity.kubelet.client_id
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
  value = {
    host                   = azurerm_kubernetes_cluster.example.kube_config[0].host
    client_certificate     = azurerm_kubernetes_cluster.example.kube_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.example.kube_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.example.kube_config[0].cluster_ca_certificate
  }
}
