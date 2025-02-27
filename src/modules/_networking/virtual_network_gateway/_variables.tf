variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "resources" {
  type = object({
    resource_groups  = map(any)
    virtual_networks = map(any)
    public_ips       = map(any)
  })
  description = "All required resources"
}
