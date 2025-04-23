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
  redis_hostname_secret_name = "redis_hostname"
  redis_pak_secret_name      = "redis_primary_key"
  capacity                   = var.redis.capacity
  sku                        = var.redis.sku
  sku_family                 = var.redis.sku_family
  common_tag                 = var.common_tag
}

module "acr" {
  source     = "./modules/acr"
  acr_name   = local.acr_name
  image_name = var.image_name
  rg = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
  acr_sku    = "standard"
  git_pat    = var.git_pat
  common_tag = var.common_tag
}

data "azurerm_container_registry" "acr_data" {
  name                = module.acr.acr_name
  resource_group_name = azurerm_resource_group.rg.name
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
  acr_login_server = data.acr_data.login_server
  image_name       = var.image_name
  image_tag        = "latest"
  kv_id            = module.kv.id
  common_tag       = var.common_tag
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = file("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.aks_kv_access_identity_id
    kv_name                    = local.kv_name
    redis_url_secret_name      = module.redis.redis_hostname_secret_name
    redis_password_secret_name = module.redis.redis_pak_secret_name
    tenant_id                  = var.tenant_id
  })
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = data.acr_data.login_server
    app_image_name   = var.image_name
    image_tag        = "latest"
    redis_url        = data.azurerm_key_vault_secret.redis_hostname.value
    redis_pwd        = data.azurerm_key_vault_secret.redis_primary_key.value
  })
  ## Block for deployment manifest
  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }
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
}