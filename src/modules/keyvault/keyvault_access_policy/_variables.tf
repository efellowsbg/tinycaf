variable "settings" {
  description = "All the configuration for this resource"
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

variable "keyvault_id" {}
variable "tenant_id" {}
variable "object_id" {}
variable "access_policy" {}
variable "global_settings" {
  description = "Global settings for tinycaf"
}
