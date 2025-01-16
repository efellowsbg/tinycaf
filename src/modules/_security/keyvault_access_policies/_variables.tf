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

variable "resources" {
  default = {}
}