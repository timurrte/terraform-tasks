resource "azurerm_user_assigned_identity" "example" {
  location            = var.rg.location
  name                = "app_identity"
  resource_group_name = var.rg.name
}

resource "azurerm_container_app_environment" "example" {
  name                = "Example-Environment"
  location            = var.rg.location
  resource_group_name = var.rg.name
}

data "azurerm_key_vault_secret" "redis-key" {
  name         = var.redis_password_name
  key_vault_id = var.kv_id

  depends_on = [azurerm_key_vault_access_policy.example]
}

data "azurerm_key_vault_secret" "redis-url" {
  name         = var.redis_hostname_name
  key_vault_id = var.kv_id

  depends_on = [azurerm_key_vault_access_policy.example]
}

resource "azurerm_container_app" "example" {
  name                         = var.aca_name
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = var.rg.name
  revision_mode                = "Single"
  workload_profile_name        = var.workload_profile_name

  secret {
    name  = "redis-url"
    value = azurerm_key_vault_secret.redis-url.value
  }
  secret {
    name  = "redis-key"
    value = azurerm_key_vault_secret.redis-key.value
  }


  template {
    container {
      name   = "containerapp"
      image  = "${var.acr.login_server}/${var.image_name}:${var.image_tag}"
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
}

data "azurerm_client_config" "current" {
}

resource "azurerm_key_vault_access_policy" "example" {
  key_vault_id = var.kv_id

  tenant_id      = data.azurerm_client_config.current.tenant_id
  object_id      = data.azurerm_client_config.current.object_id
  application_id = azurerm_container_app.example.id

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "Get",
  ]

  depends_on = [azurerm_container_app.example]
}
