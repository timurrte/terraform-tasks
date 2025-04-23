variable "rg_location" {
  description = "Resource Group location"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for names"
  type        = string
}

variable "git_pat" {
  description = "Git Personal Access token"
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

variable "k8s" {
  description = "k8s cluster config"
  type = object({
    cluster_name      = string
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

variable "redis" {
  description = "Redis module config"
  type = object({
    capacity   = string
    sku        = string
    sku_family = string
  })
}

variable "redis_host_secret_name" {
  description = "Redis hostname secret name"
  type        = string
}

variable "redis_pak_secret_name" {
  description = "Redis PAK secret name"
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

variable "aci_sku" {
  description = "ACI SKU type"
  type        = string
}