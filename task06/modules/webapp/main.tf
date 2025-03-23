resource "azurerm_service_plan" "asp" {
  name                = var.asp.name
  resource_group_name = var.rg.name
  location            = var.rg.location
  os_type             = "Linux"
  sku_name            = var.asp.sku
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app.name
  location            = var.rg.location
  resource_group_name = var.rg.name
  service_plan_id     = azurerm_service_plan.asp.id
  connection_string {
    name  = "MSSQL connection"
    type  = "SQLAzure"
    value = var.sql_connection_string
  }
  site_config {
    application_stack {
      dotnet_version = var.app.dotnet_version
    }
  }

  tags = {
    Creator = var.creator_name
  }
}
