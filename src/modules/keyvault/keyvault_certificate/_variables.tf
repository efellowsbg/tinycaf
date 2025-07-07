variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "resources" {
  description = "All trequired resources"
}

variable "keyvault_id" {
  description = "id of the keyvault"
}

variable "certificate" {
  description = "Keyvault secrets"
}

variable "client_config" {
  description = "Client config such as current landingzone key"
  type = object({
    landingzone_key = string
  })
}
