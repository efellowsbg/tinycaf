variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for a storage account"
}

variable "resources" {
  type = object({
    resource_groups = map(any)
    vnets = map(any)
    subnets = map(any)
  })
  description = "All required resources"
}