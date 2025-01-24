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
      Owner      = "Borislav Raynov",
      Project    = "Test CAF Modules",
      DeadLine   = "01/31/2025",
      DeployDate = "01/24/2025"
    }
    inherit_resource_group_tags = false
  }
}
