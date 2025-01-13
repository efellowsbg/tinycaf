variable "settings" {
  description = "All the configuration for an RG"
}

variable "resources" {
  type = object({
    resource_groups        = optional(map(any), {})
    network_security_group = optional(map(any), {})
  })
  description = "All required resources"
  default     = {}
}
