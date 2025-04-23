locals {
  rg_name       = concat([var.name_prefix, "-", "rg"])
  aci_name      = concat([var.name_prefix, "-", "aci"])
  acr_name      = concat([var.name_prefix, "-", "acr"])
  aks_name      = concat([var.name_prefix, "-", "aks"])
  keyvault_name = concat([var.name_prefix, "-", "kv"])
  redis_name    = concat([var.name_prefix, "-", "redis"])
}