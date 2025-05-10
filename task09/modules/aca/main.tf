resource "azurerm_user_assigned_identity" "example" {
  location            = var.rg.location
  name                = "app_identity"
  resource_group_name = var.rg.name
}

resource "azurerm_container_app_environment" "example" {
  name                = var.app_env_name
  location            = var.rg.location
  resource_group_name = var.rg.name
  workload_profile {
    name                  = "workload"
    workload_profile_type = var.workload_profile_type
    minimum_count         = 1
    maximum_count         = 3
  }
  tags = {
    Creator = var.common_tag
  }
}

data "azurerm_client_config" "current" {
}

resource "azurerm_key_vault_access_policy" "example" {
  key_vault_id = var.kv_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azurerm_user_assigned_identity.example.principal_id

  key_permissions = [
    "Get", "List"
  ]
  secret_permissions = [
    "Get", "List"
  ]
}

resource "null_resource" "wait_for_kv_policy" {
  depends_on = [azurerm_key_vault_access_policy.example]
}

data "azurerm_key_vault_secret" "redis-key" {
  name         = var.redis_password_name
  key_vault_id = var.kv_id

  depends_on = [null_resource.wait_for_kv_policy]
}

data "azurerm_key_vault_secret" "redis-url" {
  name         = var.redis_hostname_name
  key_vault_id = var.kv_id

  depends_on = [null_resource.wait_for_kv_policy]
}

resource "azurerm_container_app" "example" {
  name                         = var.aca_name
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = var.rg.name
  revision_mode                = "Single"
  workload_profile_name        = azurerm_container_app_environment.example.name

  identity {
    type         = "UserAssigned"
    identity_ids = azurerm_user_assigned_identity.example.id
  }

  secret {
    name  = "redis-url"
    value = data.azurerm_key_vault_secret.redis-url.value
  }
  secret {
    name  = "redis-key"
    value = data.azurerm_key_vault_secret.redis-key.value
  }


  template {
    container {
      name   = "containerapp"
      image  = "${var.acr_login_server}/${var.image_name}:latest"
      cpu    = 1
      memory = "1Gi"
      env {
        name  = "CREATOR"
        value = "ACA"
      }

      env {
        name  = "REDIS_PORT"
        value = "6380"
      }

      env {
        name        = "REDIS_URL"
        secret_name = "redis-url"
      }

      env {
        name        = "REDIS_PWD"
        secret_name = "redis-key"
      }
    }
  }

  tags = {
    Creator = var.common_tag
  }

  depends_on = [azurerm_key_vault_access_policy.example, data.azurerm_key_vault_secret.redis-key, data.azurerm_key_vault_secret.redis-url]
}
