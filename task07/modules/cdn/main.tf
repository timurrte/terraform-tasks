resource "azurerm_cdn_profile" "cdn_profile" {
  name                = "module7CdnProfile"
  location            = var.rg.location
  resource_group_name = var.rg.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "cdn_endpoint1" {
  name                = "module7CdnEndpoint"
  resource_group_name = var.rg.name
  location            = var.rg.location
  profile_name        = azurerm_cdn_profile.cdn_profile.name
  origin {
    name      = var.cdn_endpoint_name
    host_name = var.cdn_origin
  }
}