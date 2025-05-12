resource "azurerm_user_assigned_identity" "app" {
  location            = var.rg.location
  name                = "app_identity"
  resource_group_name = var.rg.name
}

resource "azurerm_container_app_environment" "example" {
  name                = var.app_env_name
  location            = var.rg.location
  resource_group_name = var.rg.name
  workload_profile {
    name                  = "Consumption"
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

resource "azurerm_key_vault_access_policy" "cli" {
  key_vault_id = var.kv_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azurerm_user_assigned_identity.app.principal_id

  key_permissions = [
    "Get", "List"
  ]
  secret_permissions = [
    "Get", "List"
  ]
}

resource "azurerm_role_assignment" "aca_acr_pull" {
  principal_id         = azurerm_user_assigned_identity.app.principal_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}

resource "null_resource" "wait_for_kv_policy" {
  depends_on = [azurerm_role_assignment.aca_acr_pull]
}

resource "time_sleep" "wait_2m" {
  depends_on      = [azurerm_role_assignment.aca_acr_pull]
  create_duration = "2m"
}

data "azurerm_key_vault_secret" "redis-key" {
  name         = var.redis_password_name
  key_vault_id = var.kv_id

  depends_on = [time_sleep.wait_2m]
}

data "azurerm_key_vault_secret" "redis-url" {
  name         = var.redis_hostname_name
  key_vault_id = var.kv_id

  depends_on = [time_sleep.wait_2m]
}
resource "azurerm_container_app" "example" {
  name                         = var.aca_name
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = var.rg.name
  revision_mode                = "Single"
  workload_profile_name        = "Consumption"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app.id]
  }

  secret {
    name  = "redis-url"
    value = data.azurerm_key_vault_secret.redis-url.value
  }
  secret {
    name  = "redis-key"
    value = data.azurerm_key_vault_secret.redis-key.value
  }

  registry {
    server   = var.acr_login_server
    identity = azurerm_user_assigned_identity.app.id
  }

  ingress {
    external_enabled = true
    target_port      = 8080
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  template {
    container {
      name   = "containerapp"
      image  = "${var.acr_login_server}/${var.image_name}:latest"
      cpu    = 1
      memory = "2Gi"
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

  depends_on = [null_resource.wait_for_kv_policy, data.azurerm_key_vault_secret.redis-key, data.azurerm_key_vault_secret.redis-url]
}
