variable "settings" {
  description = "All the configuration for this resource"
}

variable "keyvault_id" {
  description = "keyvault id"
}

variable "resources" {
  type = object({
    keyvaults    = map(any)
    virtual_networks   = map(any)
    managed_identities = map(any)
    resource_groups = map(any)
    private_dns_zones  = map(any)

  })
  description = "All required resources"
}

variable "access_policies" {
  validation {
    condition     = length(var.access_policies) <= 16
    error_message = "A maximun of 16 access policies can be set."
  }
}
variable "global_settings" {
  description = "Global settings for tinycaf"
}
