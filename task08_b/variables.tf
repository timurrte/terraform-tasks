variable "rg_location" {
  description = "Resource Group location"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for names"
  type        = string
}

variable "workload_profile_type" {
  description = "ACA name"
  type        = string
}
variable "kv_sku" {
  description = "KV SKU type"
  type        = string
}

variable "redis_password_name" {
  description = "Redis password secret name"
  type        = string
}

variable "redis_hostname_name" {
  description = "Redis Hostname secret name"
  type        = string
}
variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "object_id" {
  description = "Object ID"
  type        = string
}
variable "sp" {
  description = "Service Principal ID and secret"
  type = object({
    client_id     = string
    client_secret = string
  })
}
variable "k8s" {
  description = "k8s cluster config"
  type = object({
    node_count        = number
    node_os_disk_type = string
    node_pool_name    = string
    node_size         = string
  })
}

variable "acr_sku" {
  description = "ACR SKU type"
  type        = string
}

variable "aci_redis_sku" {
  description = "ACI Redis SKU"
  type        = string
}

variable "image_name" {
  description = "Image name"
  type        = string
}

variable "common_tag" {
  description = "Common tag for all resources"
  type        = string
}

variable "sa_replication_type" {
  description = "SA replication type"
  type        = string
}

variable "sa_container_name" {
  description = "SA replication type"
  type        = string
}

variable "sa_container_access_type" {
  description = "SA replication type"
  type        = string
}
