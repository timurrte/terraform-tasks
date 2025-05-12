tenant_id = "b41b72d0-4e9f-4c26-8a69-f949f367c91d"
object_id = "835da4ff-78ad-46f6-8bf0-313f7c80242c"
#object_id   = "ec44bbc1-76dd-4a80-ad50-697247431912"
rg_location = "westus"
name_prefix = "cmtr-a36a106e-mod8b"
kv_sku      = "standard"
k8s = {
  node_count        = 1
  node_os_disk_type = "Ephemeral"
  node_pool_name    = "system"
  node_size         = "Standard_D2ads_v5"
}
image_name          = "cmtr-a36a106e-mod8b-app"
common_tag          = "tymur_nikolaiev@epam.com"
acr_sku             = "Basic"
redis_hostname_name = "redis-hostname"
redis_password_name = "redis-password"
sp = {
  client_id     = "ee073e97-d234-497d-a2e1-2d0090ba97b4"
  client_secret = "yj98Q~QQ3i-snCiiKpTG1wX5FQsy6cVFev8GEb4_"
}
aci_redis_sku            = "Standard"
workload_profile_type    = "Consumption"
sa_replication_type      = "LRS"
sa_container_name        = "app-content"
sa_container_access_type = "private"
