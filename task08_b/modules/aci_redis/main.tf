resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_container_group" "example" {
  name                = var.redis_aci_name
  location            = var.rg.location
  resource_group_name = var.rg.name
  dns_name_label      = "aci-redis"
  ip_address_type     = "Public"
  os_type             = "Linux"

  sku = var.sku_type

  container {
    name   = "redis"
    image  = "mcr.microsoft.com/cbl-mariner/base/redis:6.2-cm2.0"
    cpu    = "1"
    memory = "2"

    ports {
      port     = 6379
      protocol = "TCP"
    }
    commands = [
      "redis-server",
      "--protected-mode", "no",
      "--requirepass", random_password.password.result
    ]
  }


  tags = {
    Creator = var.common_tag
  }
}

resource "azurerm_key_vault_secret" "redis-password" {
  name         = var.redis_password_secret_name
  value        = random_password.password.result
  key_vault_id = var.kv_id
}

resource "azurerm_key_vault_secret" "redis-hostname" {
  name         = var.redis_host_secret_name
  value        = azurerm_container_group.example.fqdn
  key_vault_id = var.kv_id
}
