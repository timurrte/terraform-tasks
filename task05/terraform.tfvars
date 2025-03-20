resource_groups = {
  rg1 = {
    name     = "rg_name_1"
    location = "rg_name_1"
  }
  rg2 = {
    name     = "rg_name_2"
    location = "rg_name_2"
  }
  rg3 = {
    name     = "rg_name_3"
    location = "rg_name_3"
  }
}

service_plans = {
  sp1 = {
    name     = "sp_name1"
    location = "sp_location1"
    rg_key   = "rg1"
  }

  sp2 = {
    name     = "sp_name2"
    location = "sp_location2"
    rg_key   = "rg2"
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
