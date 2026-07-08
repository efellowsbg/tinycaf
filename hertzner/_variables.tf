variable "hcloud_token" {
  description = "Hetzner Cloud API token. Can also be set via HCLOUD_TOKEN env var."
  type        = string
  sensitive   = true
  default     = null
}

variable "global_settings" {
  description = "Global settings for tinycaf Hetzner CAF"
  type = object({
    labels = optional(map(string), {})
  })

  default = {
    labels = {}
  }
}

variable "landingzone" {
  description = "Landing zone metadata and tfstate dependencies"
  type = object({
    backend_type = string
    key          = string
    tfstates = optional(map(object({
      tfstate = string
    })))
  })
}
