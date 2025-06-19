variable "settings" {
  type = any
}

variable "resources" {
  type        = any
  description = "Resources provided by other modules"
  default     = {}
}

variable "global_settings" {
  type        = any
  description = "Global settings shared across modules"
}

variable "client_config" {
  type        = any
  description = "Client config object (landingzone key, etc.)"
}
