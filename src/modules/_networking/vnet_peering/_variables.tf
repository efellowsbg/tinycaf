variable "global_settings" {
  description = "Global settings for tinycaf"
}

variable "settings" {
  description = "All the configuration for this resource"
}


variable "resources" {
  type = object({
    virtual_networks = map(any)
  })
  description = "All required resources"
}

variable "direction" {
  description = "Peering direction: '1to2', '2to1', or 'both'. Optional. Defaults to 'both' if unset."
  type        = string
  default     = "both"  # Changed from null to "both"
  validation {
    condition     = contains(["1to2", "2to1", "both"], var.direction)
    error_message = "Allowed values are '1to2', '2to1', or 'both'."
  }
}