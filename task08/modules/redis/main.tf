resource "azurerm_redis_cache" "redis" {
  name                 = var.redis_name
  location             = var.rg.location
  resource_group_name  = var.rg.name
  capacity             = var.capacity
  family               = var.sku_family
  sku_name             = var.sku
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"

  tags = {
    Creator = var.common_tag
  }
}

resource "azurerm_key_vault_secret" "hostname" {
  name         = var.redis_hostname_secret_name
  value        = azurerm_redis_cache.redis.hostname
  key_vault_id = var.kv_id
}
resource "azurerm_key_vault_secret" "pak" {
  name         = var.redis_pak_secret_name
  value        = azurerm_redis_cache.redis.primary_access_key
  key_vault_id = var.kv_id
}
