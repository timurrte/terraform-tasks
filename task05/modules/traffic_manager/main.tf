resource "azurerm_traffic_manager_profile" "tm_profile" {
  name                   = var.profile_name
  resource_group_name    = var.rg.name
  traffic_routing_method = var.routing_method

  dns_config {
    relative_name = var.profile_name
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = {
    Creator = var.creator
  }
}

resource "azurerm_traffic_manager_azure_endpoint" "endp" {
  for_each = var.app_services

  name                 = each.name
  profile_id           = azurerm_traffic_manager_profile.tm_profile.id
  always_serve_enabled = true
  weight               = 100
  target_resource_id   = each.id
}
