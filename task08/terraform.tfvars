tenant_id   = "b41b72d0-4e9f-4c26-8a69-f949f367c91d"
object_id   = "ee073e97-d234-497d-a2e1-2d0090ba97b4"
rg_location = "westeurope"
name_prefix = "cmtr-a36a106e-mod8"
redis = {
  cluster_name = "cluster"
  capacity     = "2"
  sku          = "Basic"
  sku_family   = "C"
}
kv_sku = "standard"
k8s = {
  node_count        = 1
  node_os_disk_type = "Ephemeral"
  node_pool_name    = "system"
  node_size         = "Standard_D2ads_v5"
}
image_name             = "cmtr-a36a106e-mod8-app"
common_tag             = "tymur_nikolaiev@epam.com"
aci_sku                = "Standard"
acr_sku                = "Standard"
redis_host_secret_name = "redis-hostname"
redis_pak_secret_name  = "redis-primary-key"