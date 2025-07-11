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
  description = "Client config such as current landingzone key"
  type = object({
    landingzone_key = string
  })
}
# variable "resource_type" {
#   description = "Type of the resource which this Private Endpoint should be connected to"
# }

# variable "resource_ref" {
#   description = "Reference of the resource which this Private Endpoint should be connected to"
# }
