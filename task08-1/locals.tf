locals {
  rg_name       = join("-", [var.name_prefix, "rg"])
  aci_name      = join("-", [var.name_prefix, "aci"])
  acr_name      = join("", [var.name_prefix, "acr"])
  aks_name      = join("-", [var.name_prefix, "aks"])
  keyvault_name = join("-", [var.name_prefix, "kv"])
  redis_name    = join("-", [var.name_prefix, "redis"])
}