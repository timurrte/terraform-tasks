variable "rg" {
  description = "Resource Group for CDN"
  type = object({
    name     = string
    location = string
  })
}

variable "cdn_endpoint_name" {
  description = "Name of the CDN endpoint"
  type = string
}

variable "cdn_origin" {
  description = "Origin hostname for CDN endpoint"
}