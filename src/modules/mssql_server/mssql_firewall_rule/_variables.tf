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

variable "rule_name" {
  description = "Firewall name as the key value"
}

variable "rules" {
  description = "Mssql firwall rules"
}

variable "client_config" {
  description = "Client config such as current landingzone key"
  type = object({
    landingzone_key = string
  })
}
