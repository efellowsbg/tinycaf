variable "subscription_id" {
  type = string
}

variable "global_settings" {
  type = object({
    tags                        = map(string),
    inherit_resource_group_tags = bool
  })

  default = {
    tags = {
      owner      = "Borislav Raynov"
      project    = "Test CAF Modules"
      deadline   = "01/31/2025"
      deploydate = "01/24/2025"
    }
    inherit_resource_group_tags = false
  }
}
