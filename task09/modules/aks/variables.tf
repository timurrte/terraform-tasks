variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "sp" {
  description = "Service Principal config"
  type = object({
    client_id     = string
    client_secret = string
  })
}

variable "node_pool" {
  description = "Node Pool configuration"
  type = object({
    name      = string
    count     = number
    size      = string
    disk_type = string
  })
}

variable "rg" {
  description = "Resource Group name and location"
  type = object({
    name     = string
    location = string
  })
}

variable "kv_id" {
  description = "Key Vault ID to grant permissions to"
  type        = string
}

variable "acr_id" {
  description = "ACR ID to pull images from"
  type        = string
}

variable "common_tag" {
  description = "Common tag"
  type        = string
}

variable "name_prefix" {
  description = "Name prefix"
  type        = string
}
