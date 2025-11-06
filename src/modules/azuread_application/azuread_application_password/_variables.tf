variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "resources" {
  description = "All required resources"
}

# variable "key_vault_id" {
#   description = "The KV where the secret will be stored"
# }

variable "client_config" {
  description = "Client config such as current landingzone key"
  type = object({
    landingzone_key = string
  })
}
