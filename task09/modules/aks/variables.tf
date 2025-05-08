variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "node_pool" {
  description = "Kubernetes cluster config"
  type = object({
    count     = string
    disk_type = string
    name      = string
    size      = string
  })
}

variable "cluster_name" {
  description = "Cluster name"
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
