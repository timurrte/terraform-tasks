resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.k8s.cluster_name
  location            = var.rg.location
  resource_group_name = var.rg.name
  dns_prefix          = var.name_prefix

  default_node_pool {
    name            = var.k8s.node_pool_name
    node_count      = var.k8s.node_count
    vm_size         = var.k8s.node_size
    os_disk_type    = var.k8s.node_os_disk_type
    os_disk_size_gb = "30"
  }

  network_profile {
    network_plugin = "azure"
  }

  identity {
    type = "SystemAssigned"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = {
    Creator = var.common_tag
  }
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id                                                  # ID твого ACR
  role_definition_name = "AcrPull"                                                   # Роль яка дозволяє тільки pull
  principal_id         = azurerm_kubernetes_cluster.cluster.identity[0].principal_id # Identity кластера
}

resource "azurerm_role_assignment" "aks_kv_secret_reader" {
  scope                = var.key_vault_id
  role_definition_name = "Reader"
  principal_id         = azurerm_kubernetes_cluster.cluster.identity[0].principal_id # Identity кластера
}

resource "azurerm_key_vault_access_policy" "kv_access" {
  key_vault_id = var.key_vault_id

  tenant_id = azurerm_kubernetes_cluster.cluster.identity[0].tenant_id
  object_id = azurerm_kubernetes_cluster.cluster.identity[0].principal_id

  secret_permissions = [
    "Get", "List"
  ]

  depends_on = [azurerm_kubernetes_cluster.cluster]
}
