resource "azurerm_user_assigned_identity" "kubelet" {
  location            = var.rg.location
  name                = "kubelet_identity"
  resource_group_name = var.rg.name
}

resource "azurerm_user_assigned_identity" "uami" {
  location            = var.rg.location
  name                = "ua_identity"
  resource_group_name = var.rg.name
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = var.cluster_name
  location            = var.rg.location
  resource_group_name = var.rg.name
  dns_prefix          = var.name_prefix
  default_node_pool {
    name            = var.node_pool.name
    node_count      = var.node_pool.count
    vm_size         = var.node_pool.size
    os_disk_type    = var.node_pool.disk_type
    os_disk_size_gb = 50
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.uami.id]
  }

  kubelet_identity {
    client_id                 = azurerm_user_assigned_identity.kubelet.client_id
    object_id                 = azurerm_user_assigned_identity.kubelet.principal_id
    user_assigned_identity_id = azurerm_user_assigned_identity.kubelet.id
  }

  tags = {
    Creator = var.common_tag
  }
}

resource "azurerm_role_assignment" "uami_can_assign_kubelet" {
  scope                = azurerm_user_assigned_identity.kubelet.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.uami.principal_id
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.example.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}

resource "azurerm_role_assignment" "uami_kv_secret_user" {
  scope                = var.kv_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.uami.principal_id
}

resource "azurerm_role_assignment" "uami_kv_reader" {
  scope                = var.kv_id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.uami.principal_id
}
resource "azurerm_key_vault_access_policy" "kv_access" {
  key_vault_id = var.kv_id

  tenant_id = azurerm_user_assigned_identity.uami.tenant_id
  object_id = azurerm_user_assigned_identity.uami.principal_id
  secret_permissions = [
    "Get", "List", "Set", "Delete", "Backup", "Purge", "Recover", "Restore"
  ]
}
