variable "settings" {
  description = "Settings for diagnostic settings"
  type = object({
    name                       = string
    resource_type              = string
    resource_ref               = string
    resource_lz_key            = optional(string)
    storage_account_ref        = optional(string)
    storage_account_lz_key     = optional(string)
    log_analytics_workspace_ref = optional(string)
    log_analytics_lz_key       = optional(string)
    logs = optional(map(object({
      category = string
      enabled  = bool
      retention_policy = optional(object({
        enabled = bool
        days    = number
      }))
    })))
    metrics = optional(map(object({
      category = string
      enabled  = bool
      retention_policy = optional(object({
        enabled = bool
        days    = number
      }))
    })))
  })
}
