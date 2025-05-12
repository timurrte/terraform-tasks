locals {
  rg_name        = join("-", [var.name_prefix, "rg"])
  redis_aci_name = join("-", [var.name_prefix, "ci"])
  aca_name       = join("-", [var.name_prefix, "aca"])
  aca_env_name   = join("-", [var.name_prefix, "aca-env"])
  acr_name       = "cmtra36a106emod8cr"
  aks_name       = join("-", [var.name_prefix, "aks"])
  keyvault_name  = join("-", [var.name_prefix, "kv"])
  sa_name        = "cmtra36a106emod8sa"
}
