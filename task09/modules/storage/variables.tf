variable "rg" {
  description = "Resource Group name and location"
  type = object({
    name     = string
    location = string
  })
}

variable "storage_account_name" {
  description = "SA name"
  type        = string
}

variable "sa_replication_type" {
  description = "SA replication type"
  type        = string
}

variable "sa_container_name" {
  description = "SA container name"
  type        = string
}

variable "sa_container_access_type" {
  description = "SA container access type"
  type        = string
}

variable "app_dir" {
  type        = string
  description = "Path to the application directory to archive"
}
