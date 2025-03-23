name_prefix = "cmaz-a36a106e-mod6"

rg = {
  name     = "rg"
  location = "northeurope"
}

kv = {
  username_secret = "sql-admin-name"
  password_secret = "sql-admin-password"
}

sql = {
  sku_type = "S2"
}

firewall_rule_name = "allow-verification-ip"

allowed_ip_address = "18.153.146.156"

asp = {
  sku = "P0v3"
}

app = {
  dotnet_version = "8.0"
}

creator = "tymur_nikolaiev@epam.com"
