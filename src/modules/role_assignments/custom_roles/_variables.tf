variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for a custom role"
}

variable "resources" {
  description = "All required resources"
}

variable "resource_type" {
  description = "The type of resource being processed (e.g., keyvaults)"
  type        = string
}
