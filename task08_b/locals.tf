locals {
  rg_name        = join("-", [var.name_prefix, "rg"])
  redis_aci_name = join("-", [var.name_prefix, "redis-ci"])
  aca_name       = join("-", [var.name_prefix, "ca"])
  aca_env_name   = join("-", [var.name_prefix, "cae"])
  acr_name       = "cmtra36a106emod8bcr"
  aks_name       = join("-", [var.name_prefix, "aks"])
  keyvault_name  = join("-", [var.name_prefix, "kv"])
  sa_name        = "cmtra36a106emod8bsa"
}
