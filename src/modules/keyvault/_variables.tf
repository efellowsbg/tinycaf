variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
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

variable "keyvaults" {
  default = {}
}
variable "keyvault_key" {
  default = null
}
variable "keyvault_id" {
  default = null
}

variable "access_policies" {
  validation {
    condition     = length(var.access_policies) <= 16
    error_message = "A maximun of 16 access policies can be set."
  }
}
