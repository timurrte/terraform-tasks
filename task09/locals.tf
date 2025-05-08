locals {
  rg_name       = join("-", [var.name_prefix, "rg"])
  aci_name      = join("-", [var.name_prefix, "ci"])
  acr_name      = "cmtra36a106emod8cr"
  aks_name      = join("-", [var.name_prefix, "aks"])
  keyvault_name = join("-", [var.name_prefix, "kv"])
  redis_name    = join("-", [var.name_prefix, "redis"])
}