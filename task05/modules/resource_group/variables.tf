variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group"
}

variable "creator" {
  type        = string
  description = "Creator tag value"
}
