variable "resources" {
  description = "CAF resources map from root module"
  type        = any
}

variable "client_config" {
  description = "Client config including landingzone key"
  type = object({
    landingzone_key = string
  })
}

variable "global_settings" {
  description = "Global settings passed from root"
  type = object({
    tags                        = map(string)
    inherit_resource_group_tags = bool
  })
}
variable "settings" {
  default = {}
}

