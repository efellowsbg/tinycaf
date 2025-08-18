variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "subscription_id" {
  description = "The ID of the subscription"
}

variable "resources" {
  description = "All required resources"
}

variable "client_config" {
  description = "Client configuration for the module"
  
}

variable "resource_type" {
  description = "The type of resource being processed (e.g., keyvaults)"
  type        = string
}
