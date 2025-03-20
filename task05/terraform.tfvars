resource_groups = {
  rg1 = {
    name     = rg_name_1
    location = rg_name_1
  }
  rg2 = {
    name     = rg_name_2
    location = rg_name_2
  }
  rg3 = {
    name     = rg_name_3
    location = rg_name_3
  }
}

service_plans = {
  sp1 = {
    name     = sp_name1
    location = sp_location1
  }

  sp2 = {
    name     = sp_name2
    location = sp_location2
  }

  sp3 = {
    name     = sp_name3
    location = sp_location3
  }
}

app_services = {
  sv1 = {
    name                  = sv_name
    ip_restr_rule_name    = name
    allowed_ip            = ip
    allowed_tag_rule_name = name
    allowed_tag           = tag
  }
  sv2 = {
    name                  = sv_name
    ip_restr_rule_name    = name
    allowed_ip            = ip
    allowed_tag_rule_name = name
    allowed_tag           = tag
  }
  sv3 = {
    name                  = sv_name
    ip_restr_rule_name    = name
    allowed_ip            = ip
    allowed_tag_rule_name = name
    allowed_tag           = tag
  }

}
