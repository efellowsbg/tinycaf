variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"

  validation {
    condition     = contains(["<-", "->", "<->", "target", "source"], try(var.settings.direction, "<->"))
    error_message = "Allowed values for 'direction' are '<-', '->', '<->', 'target', or 'source'. Defaults to '<->' if not set."
  }
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
