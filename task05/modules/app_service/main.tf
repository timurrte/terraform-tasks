resource "azurerm_windows_web_app" "example" {
  name                = var.app_name
  resource_group_name = var.rg.name
  location            = var.rg.location
  service_plan_id     = var.sp_id

  site_config {

    ip_restriction {
      name       = var.ip_restriction_rule_name
      action     = "Allow"
      ip_address = var.allowed_ip
      priority   = 101
    }
    ip_restriction {
      name        = var.allow_tag_rule_name
      action      = "Allow"
      service_tag = var.allowed_tag
      priority    = 103
    }
    ip_restriction {
      name     = "DenyAll"
      action   = "Deny"
      priority = 505
    }
  }

  tags = {
    Creator = var.creator
  }
}
