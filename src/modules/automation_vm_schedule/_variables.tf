variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "vm_key" {
  description = "The map key identifying the VM in virtual_machines_default"
  type        = string
}

variable "resources" {
  description = "All required resources"
}

variable "client_config" {
  description = "Client config such as current landingzone key"
  type = object({
    landingzone_key = string
  })
}
