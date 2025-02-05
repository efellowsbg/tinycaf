variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "resources" {
  description = "All required resources"
}

variable "storage_acccount_id" {
  description = "id of the keyvault"
}

variable "subnet_ref" {
  description = "Subnet reference"
}

variable "dns_zones_ref" {
  description = "Dns zone references"
}
