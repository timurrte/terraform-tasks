resource "azurerm_windows_web_app" "app1" {
  name                = var.app_name
  resource_group_name = var.rg.name
  location            = var.rg.location
  service_plan_id     = var.sp_id

  site_config {
    dynamic "ip_restriction" {
      for_each = var.ip_rules
      content {
        name        = ip_restriction.value["name"]
        action      = ip_restriction.value["action"]
        priority    = ip_restriction.value["priority"]
        ip_address  = lookup(ip_restriction.value, "ip_address", null)
        service_tag = lookup(ip_restriction.value, "service_tag", null)
      }
    }
  }
  tags = {
    Creator = var.creator
  }
}
