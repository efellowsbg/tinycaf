variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
  validation {
    condition = (
      (contains(keys(var.settings), "gateway_address") && !contains(keys(var.settings), "gateway_fqdn") && var.settings.gateway_address != "") ||
      (contains(keys(var.settings), "gateway_fqdn") && !contains(keys(var.settings), "gateway_address") && var.settings.gateway_fqdn != "")
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
