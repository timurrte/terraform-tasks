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

variable "git_pat" {
  description = "GIT PAT"
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
