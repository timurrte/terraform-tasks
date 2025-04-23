tenant_id   = "b41b72d0-4e9f-4c26-8a69-f949f367c91d"
object_id   = "ee073e97-d234-497d-a2e1-2d0090ba97b4"
rg_location = "westeurope"
name_prefix = "module8"
redis = {
  cluster_name = "cluster"
  capacity     = "1"
  sku          = "Standard"
  sku_family   = "C"
}
k8s = {
  cluster_name      = "k4s"
  node_count        = 1
  node_os_disk_type = "Managed"
  node_pool_name    = "alpha"
  node_size         = "B1av2"
}
image_name             = "myapp"
common_tag             = "tymur_nikolaiev@epam.com"
aci_sku                = "Standard"
acr_sku                = "Standard"
redis_host_secret_name = "redis-hostname"
redis_pak_secret_name  = "redis-pak"