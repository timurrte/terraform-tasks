resource_groups = {
  rg1 = {
    name     = "cmaz-a36a106e-mod5-rg-01"
    location = "eastus"
  }
  rg2 = {
    name     = "cmaz-a36a106e-mod5-rg-02"
    location = "westus"
  }
  rg3 = {
    name     = "cmaz-a36a106e-mod5-rg-03"
    location = "easteurope"
  }
}

service_plans = {
  sp1 = {
    name           = "cmaz-a36a106e-mod5-asp-01"
    location       = "sp_location1"
    rg_key         = "rg1"
    instance_count = 2
    sku_type       = "P0v3"
  }

  sp2 = {
    name           = "sp_name2"
    location       = "sp_location2"
    rg_key         = "rg2"
    instance_count = 1
    sku_type       = "P1v3"
  }
}

app_services = {
  sv1 = {
    sp_key                = "sp1"
    name                  = "sv_name"
    ip_restr_rule_name    = "name"
    allowed_ip            = "ip"
    allowed_tag_rule_name = "name"
    allowed_tag           = "AzureTrafficManager"
  }
  sv2 = {
    name                  = "sv_name"
    ip_restr_rule_name    = "name"
    allowed_ip            = "ip"
    allowed_tag_rule_name = "name"
    allowed_tag           = "AzureTrafficManager"
  }
}

tm = {
  profile_name   = "name"
  routing_method = "method"
}
