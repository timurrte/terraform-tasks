tenant_id = "b41b72d0-4e9f-4c26-8a69-f949f367c91d"
#object_id   = "835da4ff-78ad-46f6-8bf0-313f7c80242c"
object_id   = "ec44bbc1-76dd-4a80-ad50-697247431912"
rg_location = "westus"
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
