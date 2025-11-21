variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "resources" {
  description = "All required resources"
}

variable "mssql_server_id" {
  description = "Id of the mssql server"
}

variable "elastic_pool_id" {
  description = "Id of the elastic pool"
}

variable "database_name" {
  description = "Database name as the key value"
}

variable "databases" {
  description = "Database"
}

variable "client_config" {
  description = "Client config such as current landingzone key"
  type = object({
    landingzone_key = string
  })
}
