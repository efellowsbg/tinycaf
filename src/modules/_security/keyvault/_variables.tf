variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "tenant_id" {
  description = "Tenant ID"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "resources" {
  type = object({
    resource_groups  = map(any)
    virtual_networks = map(any)
  })
  description = "All required resources"
}

variable "enable_policy_update_delay" {
  description = "(Optional) Enable a delay after Key Vault access policy updates"
  type        = bool
  default     = false
}