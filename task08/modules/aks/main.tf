resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.k8s.cluster_name
  location            = var.rg.location
  resource_group_name = var.rg.name
  dns_prefix          = var.name_prefix
  kubelet_identity {
    client_id                 = azurerm_user_assigned_identity.aks_kubelet_identity.client_id
    object_id                 = azurerm_user_assigned_identity.aks_kubelet_identity.principal_id
    user_assigned_identity_id = azurerm_user_assigned_identity.aks_kubelet_identity.id
  }

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
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = {
    Creator = var.common_tag
  }

  depends_on = [azurerm_user_assigned_identity.aks_identity]
}
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}

resource "azurerm_role_assignment" "uami_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}

resource "azurerm_role_assignment" "uami_kv_secret_user" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}

resource "azurerm_role_assignment" "uami_kv_reader" {
  scope                = var.key_vault_id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}

resource "azurerm_user_assigned_identity" "aks_kubelet_identity" {
  name                = "${var.name_prefix}-aks-kubelet"
  location            = var.rg.location
  resource_group_name = var.rg.name
}

resource "azurerm_key_vault_access_policy" "kv_access" {
  key_vault_id = var.key_vault_id

  tenant_id = azurerm_user_assigned_identity.aks_identity.tenant_id
  object_id = azurerm_user_assigned_identity.aks_identity.principal_id

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Backup", "Purge", "Recover", "Restore"
  ]
}

resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = "${var.name_prefix}-aks-identity"
  location            = var.rg.location
  resource_group_name = var.rg.name
}

resource "azurerm_role_assignment" "vmss_mi_access" {
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_kubernetes_cluster.cluster.node_resource_group_id

  depends_on = [
    azurerm_user_assigned_identity.aks_identity,
    azurerm_kubernetes_cluster.cluster
  ]
}
resource "azurerm_role_assignment" "kubelet_operator_role" {
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
  role_definition_name = "Managed Identity Operator"
  scope                = azurerm_user_assigned_identity.aks_kubelet_identity.id
}

resource "azurerm_role_assignment" "vmss_kv_user_access" {
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = azurerm_kubernetes_cluster.cluster.node_resource_group_id

  depends_on = [
    azurerm_user_assigned_identity.aks_identity,
    azurerm_kubernetes_cluster.cluster
  ]
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = azurerm_kubernetes_cluster.cluster.name
  resource_group_name = azurerm_kubernetes_cluster.cluster.resource_group_name
}

data "azurerm_resource_group" "aks_node_rg" {
  name = data.azurerm_kubernetes_cluster.aks.node_resource_group
}
resource "azurerm_role_assignment" "kubelet_kv_user" {
  principal_id         = azurerm_user_assigned_identity.aks_kubelet_identity.principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = var.key_vault_id
}

resource "azurerm_key_vault_access_policy" "kubelet_kv_policy" {
  key_vault_id = var.key_vault_id
  tenant_id    = azurerm_user_assigned_identity.aks_kubelet_identity.tenant_id
  object_id    = azurerm_user_assigned_identity.aks_kubelet_identity.principal_id

  secret_permissions = ["Get"]
}
