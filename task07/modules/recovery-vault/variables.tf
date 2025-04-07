variable "rg" {
  description = "Resource Group for CDN"
  type = object({
    name     = string
    location = string
  })
}