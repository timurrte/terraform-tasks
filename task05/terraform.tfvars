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
    location = "westeurope"
  }
}

service_plans = {
  sp1 = {
    name           = "cmaz-a36a106e-mod5-asp-01"
    rg_key         = "rg1"
    instance_count = 2
    sku_type       = "P0v3"
  }

  sp2 = {
    name           = "cmaz-a36a106e-mod5-asp-02"
    rg_key         = "rg2"
    instance_count = 1
    sku_type       = "P1v3"
  }
}

app_services = {
  sv1 = {
    sp_key = "sp1"
    rg_key = "rg1"
    name   = "cmaz-a36a106e-mod5-app-01"
  }
  sv2 = {
    sp_key = "sp2"
    rg_key = "rg2"
    name   = "cmaz-a36a106e-mod5-app-02"
  }
}

ip_rules = [
  {
    name        = "allow-ip"
    action      = "Allow"
    ip_address  = "18.153.146.156/32"
    service_tag = null
  },
  {
    name        = "allow-tm"
    action      = "Allow"
    ip_address  = null
    service_tag = "AzureTrafficManager"
}]

traf = {
  traf_1 = {
    profile_name   = "cmaz-a36a106e-mod5-traf"
    routing_method = "Performance"
} }

creator = "tymur_nikolaiev@epam.com"
