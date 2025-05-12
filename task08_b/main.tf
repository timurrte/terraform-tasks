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
  object_id  = var.object_id
  kv_sku     = var.kv_sku
  common_tag = var.common_tag

}

module "aci_redis" {
  source = "./modules/aci_redis"
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  redis_password_secret_name = var.redis_password_name
  redis_host_secret_name     = var.redis_hostname_name
  redis_aci_name             = local.redis_aci_name
  kv_id                      = module.kv.id
  sku_type                   = var.aci_redis_sku
  common_tag                 = var.common_tag
  depends_on                 = [module.kv.kv_policy]
}

module "acr" {
  source     = "./modules/acr"
  acr_name   = local.acr_name
  image_name = var.image_name
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  access_token            = module.storage.sas_token
  acr_sku                 = var.acr_sku
  common_tag              = var.common_tag
  app_archive_context_url = module.storage.context_url
  depends_on              = [module.kv.kv_policy, module.storage]
}

module "aca" {
  source = "./modules/aca"

  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  uami_id               = module.aks.uami_id
  uami_principal        = module.aks.uami_principal
  app_env_name          = local.aca_env_name
  redis_password_name   = var.redis_password_name
  redis_hostname_name   = var.redis_hostname_name
  image_name            = var.image_name
  kv_id                 = module.kv.id
  acr_login_server      = module.acr.login_server
  aca_name              = local.aca_name
  workload_profile_type = var.workload_profile_type
  common_tag            = var.common_tag

  acr_id     = module.acr.id
  depends_on = [module.aci_redis, module.acr, module.aks]
}

module "aks" {
  source = "./modules/aks"

  cluster_name = local.aks_name
  node_pool = {
    count     = var.k8s.node_count
    disk_type = var.k8s.node_os_disk_type
    name      = var.k8s.node_pool_name
    size      = var.k8s.node_size
  }
  kv_id  = module.kv.id
  acr_id = module.acr.id
  sp = {
    client_id     = var.sp.client_id
    client_secret = var.sp.client_secret
  }
  name_prefix = var.name_prefix
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  common_tag = var.common_tag

  depends_on = [module.kv.kv_policy]
}

module "storage" {
  source = "./modules/storage"

  app_dir = "application"

  storage_account_name = local.sa_name
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }

  sa_replication_type      = var.sa_replication_type
  sa_container_name        = var.sa_container_name
  sa_container_access_type = var.sa_container_access_type
  common_tag               = var.common_tag
}

resource "time_sleep" "wait_for_aks" {
  depends_on      = [module.aks]
  create_duration = "3m"
}

module "k8s" {
  source = "./modules/k8s/"
  providers = {
    kubectl    = kubectl.k8s
    kubernetes = kubernetes.aks
  }
  aks_kv_access_identity_id = module.aks.kubelet_identity_id
  redis_pak_secret_name     = var.redis_password_name
  redis_host_secret_name    = var.redis_hostname_name
  keyvault_name             = local.keyvault_name
  acr_login_server          = module.acr.login_server
  app_image_name            = var.image_name
  kv_id                     = module.kv.id

  aks_config = module.aks.config
}
