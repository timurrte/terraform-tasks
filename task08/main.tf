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
  tenant_id  = var.tenant_id
  object_id  = var.object_id
  sku        = var.kv_sku
  common_tag = var.common_tag

}

module "redis" {
  source = "./modules/redis"
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  redis_name                 = local.redis_name
  kv_id                      = module.kv.id
  redis_hostname_secret_name = var.redis_host_secret_name
  redis_pak_secret_name      = var.redis_pak_secret_name
  capacity                   = var.redis.capacity
  sku                        = var.redis.sku
  sku_family                 = var.redis.sku_family
  common_tag                 = var.common_tag

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

module "aks" {
  source = "./modules/aks"
  k8s = {
    cluster_name      = local.aks_name
    node_count        = var.k8s.node_count
    node_os_disk_type = var.k8s.node_os_disk_type
    node_pool_name    = var.k8s.node_pool_name
    node_size         = var.k8s.node_size
  }
  key_vault_id = module.kv.id
  acr_id       = module.acr.id
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  name_prefix = var.name_prefix
  common_tag  = var.common_tag

  depends_on = [module.kv.kv_policy]
}

module "aci" {
  source      = "./modules/aci"
  aci_name    = local.aci_name
  aci_sku     = var.aci_sku
  name_prefix = var.name_prefix
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  acr_login_server       = module.acr.acr_login_server
  image_name             = var.image_name
  image_tag              = "latest"
  redis_host_secret_name = var.redis_host_secret_name
  redis_pak_secret_name  = var.redis_pak_secret_name
  kv_id                  = module.kv.id
  common_tag             = var.common_tag

  acr = {
    login_server   = module.acr.login_server
    admin_username = module.acr.admin_username
    admin_password = module.acr.admin_password
  }

  depends_on = [data.azurerm_key_vault_secret.redis_pwd]
}

data "azurerm_key_vault_secret" "redis_host" {
  name         = var.redis_host_secret_name
  key_vault_id = module.kv.id

  depends_on = [module.redis, module.redis.pak, module.redis.host]
}

data "azurerm_key_vault_secret" "redis_pwd" {
  name         = var.redis_pak_secret_name
  key_vault_id = module.kv.id

  depends_on = [module.redis, module.redis.pak, module.redis.host]
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.aks_kv_access_identity_id
    kv_name                    = local.keyvault_name
    redis_url_secret_name      = var.redis_host_secret_name
    redis_password_secret_name = var.redis_pak_secret_name
    tenant_id                  = var.tenant_id
  })

  depends_on = [module.aks]
}


resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = var.image_name
    image_tag        = "latest"
    redis_url        = data.azurerm_key_vault_secret.redis_host.value
    redis_pwd        = data.azurerm_key_vault_secret.redis_pwd.value
  })
  ## Block for deployment manifest
  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }


  depends_on = [kubectl_manifest.secret_provider]
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  ## Block for service manifest
  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.deployment]
}

data "kubernetes_service" "app" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }

  depends_on = [kubectl_manifest.service]
}
