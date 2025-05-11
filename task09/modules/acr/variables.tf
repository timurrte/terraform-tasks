variable "acr_name" {
  description = "Container Registry name"
  type        = string
}

variable "rg" {
  description = "Resource Group name and location"
  type = object({
    name     = string
    location = string
  })
}

variable "acr_sku" {
  description = "ACR SKU type"
  type        = string
}

variable "image_name" {
  description = "Container image name"
  type        = string
}

variable "common_tag" {
  description = "Common tag"
  type        = string
}

variable "app_archive_context_url" {
  description = "App archive context URL"
  type        = string
}

variable "access_token" {
  description = "SA SAS token"
  type        = string
}
