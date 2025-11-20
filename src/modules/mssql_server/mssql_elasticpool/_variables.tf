variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "resources" {
  description = "All required resources"
}

variable "mssql_server_name" {
  description = "Name of the mssql server"
}

variable "elastic_name" {
  description = "Elasticpool name as the key value"
}

variable "elasticpools" {
  description = "Mssql elasticpools"
}

variable "client_config" {
  description = "Client config such as current landingzone key"
  type = object({
    landingzone_key = string
  })
}
