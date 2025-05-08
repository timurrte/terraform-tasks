resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.rg_location

  tags = {
    Creator = var.common_tag
  }
}

module "kv" {
  source  = "./modules/keyvault"
  kv_name = local.keyvault_name
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  sku        = var.kv_sku
  common_tag = var.common_tag

}

module "aci_redis" {
  source = "./modules/aci_redis"
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  redis_aci_name = var.redis_aci_name
  kv_id          = module.kv.id

  depends_on = [module.kv.kv_policy]
}

module "acr" {
  source     = "./modules/acr"
  acr_name   = local.acr_name
  image_name = var.image_name
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  acr_sku    = var.acr_sku
  git_pat    = var.git_pat
  common_tag = var.common_tag

  depends_on = [module.kv.kv_policy]
}

module "aca" {
  source = "./modules/aca"

  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }

  redis_password_name = var.redis_password_name
  redis_hostname_name = var.redis_hostname_name

  kv_id = module.kv.id

  aca_name              = var.aca_name
  workload_profile_name = var.workload_profile_name
}

module "aks" {
  source = "./modules/aks"

  cluster_name = local.aks_name
  k8s = {
    node_count        = var.k8s.node_count
    node_os_disk_type = var.k8s.node_os_disk_type
    node_pool_name    = var.k8s.node_pool_name
    node_size         = var.k8s.node_size
  }
  kv_id  = module.kv.id
  acr_id = module.acr.id
  sp = {
    client_id     = var.sp.client_id
    client_secret = var.sp.client_secret
  }
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  name_prefix = var.name_prefix
  common_tag  = var.common_tag

  depends_on = [module.kv.kv_policy]
}
