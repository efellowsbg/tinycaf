variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
  validation {
  condition = (
    (!isnull(try(var.settings.gateway_address, null)) && try(var.settings.gateway_address, "") != "" && isnull(try(var.settings.gateway_fqdn, null))) ||
    (!isnull(try(var.settings.gateway_fqdn, null)) && try(var.settings.gateway_fqdn, "") != "" && isnull(try(var.settings.gateway_address, null)))
  )
  error_message = "You must specify **either** 'gateway_address' **or** 'gateway_fqdn', but not both and not neither."
}
}

variable "resources" {
  type = object({
    resource_groups = map(any)
  })
  description = "All required resources"
}
