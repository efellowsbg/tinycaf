variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "resources" {
  description = "All required resources"
}

variable "client_config" {
  description = "Information about the current landingzone context"
  type = object({
    landingzone_key = string
  })
}