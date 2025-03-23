name_prefix = "jujunon"

rg = {
  name     = "rg"
  location = "westeurope"
}

kv = {
  name            = "keyvault-1357642"
  tenant_id       = "b41b72d0-4e9f-4c26-8a69-f949f367c91d"
  username_secret = "hello-user"
  password_secret = "hello-password"
}

sql = {
  server_name = "sql-server"
  db_name     = "database"
  sku_type    = "Basic"
}

firewall = {
  rule_name  = "rule-no-one"
  allowed_ip = "77.239.165.13"
}

asp = {
  name = "asp1"
  sku  = "B1"
}

app = {
  name           = "app1"
  dotnet_version = "8.0"
}

creator = "tymur_nikolaiev@epam.com"
