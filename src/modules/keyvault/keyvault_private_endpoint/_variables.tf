variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "keyvault_id" {
  description = "id of the keyvault"
}

variable "resources" {
  type = object({
    keyvaults    = map(any)
    virtual_networks   = map(any)
    managed_identities = map(any)
    private_dns_zones  = map(any)

  })
  description = "All required resources"
}

variable "resources" {
  description = "All the configuration for this resource"
}

variable "subnet_ref" {
  description = "All the configuration for this resource"
}

variable "dns_zones_ref" {
  description = "All the configuration for this resource"
}
