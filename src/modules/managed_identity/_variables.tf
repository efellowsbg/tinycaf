variable "settings" {
  description = "All the configuration for an RG"
}

variable "resources" {
  type = object({
    resource_groups = map(any)
  })
  description = "All required resources"
}