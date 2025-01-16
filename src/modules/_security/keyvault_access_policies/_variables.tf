variable "keyvaults" {
  default = {}
}
variable "keyvault_key" {
  default = null
}
variable "keyvault_id" {
  default = null
}

variable "tenant_id" {
  default = {}
}

variable "access_policies" {
  validation {
    condition     = length(var.access_policies) <= 16
    error_message = "A maximun of 16 access policies can be set."
  }
}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "resources" {
  type = object({
    resource_groups  = map(any)
    virtual_networks = map(any)
    keyvaults = map(any)
  })
  description = "All required resources"
}