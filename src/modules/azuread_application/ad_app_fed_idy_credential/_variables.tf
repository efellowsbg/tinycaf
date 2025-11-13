variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "resources" {
  description = "All required resources"
}

variable "application_id" {
  description = "The ID of the Azure AD application for which to create the password"
}

variable "application_name" {
  description = "The Name of the Azure AD application"
}

variable "client_config" {
  description = "Client config such as current landingzone key"
  type = object({
    landingzone_key = string
  })
}
