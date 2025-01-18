variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "managed_identities" {
  description = "All the configuration for this resource"
}

variable "resources" {
  type = object({
    resource_groups    = map(any)
    virtual_networks   = map(any)
    managed_identities = map(any)
    private_dns_zones  = map(any)
    keyvaults = map(any)

  })
  description = "All required resources"
}

variable "keyvault_key" {
  default = null
}
variable "keyvault_id" {
  default = null
}

variable "access_policies" {
  description = "Map of access policies for the Key Vault"
  type        = map(any)
  default     = {}
}
