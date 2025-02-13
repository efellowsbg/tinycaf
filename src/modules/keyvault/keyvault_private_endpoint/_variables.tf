variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}

variable "resources" {
  description = "All required resources"
}

variable "keyvault_id" {
  description = "id of the keyvault"
}

variable "subnet_ref" {
  description = "Reference for subnet"
}

variable "dns_zones_ref" {
  description = "Reference for DNS zone"
}
