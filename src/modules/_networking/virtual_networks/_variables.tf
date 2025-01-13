variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}


variable "resources" {
  type = object({
    resource_groups = map(any)
    virtual_networks = map(any)
  })
  description = "All required resources"
}

variable "direction" {
  description = "Peering direction: '1to2', '2to1', or 'both'. Optional. Defaults to 'both' if unset."
  type        = string
  default     = null
  validation {
    condition     = var.direction == null || contains(["1to2", "2to1", "both"], var.direction)
    error_message = "Allowed values are '1to2', '2to1', or 'both'."
  }
}