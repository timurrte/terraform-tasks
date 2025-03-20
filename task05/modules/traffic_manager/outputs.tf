variable "app_name" {
  type        = string
  description = "Windows Web App name"
}

variable "rg" {
  type        = map(any)
  description = "Resource group"
}
