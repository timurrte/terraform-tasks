resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = var.aks_kv_access_identity_id
    kv_name                    = var.keyvault_name
    redis_url_secret_name      = var.redis_host_secret_name
    redis_password_secret_name = var.redis_pak_secret_name
    tenant_id                  = var.tenant_id
  })

}

data "azurerm_key_vault_secret" "redis_host" {
  name         = var.redis_host_secret_name
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "redis_pwd" {
  name         = var.redis_pak_secret_name
  key_vault_id = var.kv_id
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = var.acr_login_server
    app_image_name   = var.app_image_name
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

data "kubernetes_service" "example" {
  metadata {
    name = "service"
  }
}
