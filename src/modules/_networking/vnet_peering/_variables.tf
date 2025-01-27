variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
  validation {
    condition     = contains(["<-", "->", "<->"], try(var.settings.direction, "<->"))
    error_message = "Allowed values for direction are '<-', '->', or '<->'. Defaults to '<->' if not set."
  }
}

variable "resources" {
  description = "All required resources"
}
