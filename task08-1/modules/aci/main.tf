data "azurerm_key_vault_secret" "host" {
  name         = "redis_hostname"
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "key" {
  name         = "redis_primary_key"
  key_vault_id = var.kv_id
}

resource "azurerm_container_group" "example" {
  name                = var.aci_name
  location            = var.rg.location
  resource_group_name = var.rg.name
  ip_address_type     = "Public"
  sku                 = var.aci_sku
  dns_name_label      = "${var.name_prefix}-aci"
  os_type             = "Linux"

  container {
    name   = "app"
    image  = "${var.acr_login_server}/${var.image_name}:${var.image_tag}"
    cpu    = 1
    memory = 1.0

    environment_variables = {
      CREATOR        = "ACI"
      REDIS_PORT     = "6380"
      REDIS_SSL_MODE = "True"
    }

    secure_environment_variables = {
      REDIS_URL = azurerm_key_vault_secret.host
      REDIS_PWD = azurerm_key_vault_secret.key
    }

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
  tags = {
    Creator = var.common_tag
  }
}