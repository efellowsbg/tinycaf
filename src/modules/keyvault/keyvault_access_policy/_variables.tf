variable "settings" {
  description = "All the configuration for this resource"
}

variable "keyvault_id" {
  description = "keyvault id"
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

variable "policy_name" {
  description = "The name of the access policy (e.g., policy1, policy2)"
  type        = string
}

variable "resources" {
  description = "All the configuration for this resource"
}
