variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "tfstate_rg_name" {
  type = string
}

variable "tfstate_storage_account_name" {
  type = string
}

variable "tfstate_container_name" {
  type = string
}


variable "remote_state_subscription_id" {
  type = string
}

variable "global_settings" {
  type = object({
    tags                        = map(string),
    inherit_resource_group_tags = bool
  })

  default = {
    tags                        = {}
    inherit_resource_group_tags = false
  }
}


variable "landingzone" {
  description = "Landing zone metadata and tfstate dependencies"
  type = object({
    backend_type = string
    key          = string
    tfstates = optional(map(object({
      tfstate         = string
      subscription_id = string
    })))
  })
}
variable "resources" {
  description = "CAF resources map passed from root or higher-level module"
  type        = any
}
variable "vm_password" {
  description = "Password for the Linux VM. Must meet Azure's complexity requirements."
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "project-rg"
}

variable "storage_account_name" {
  description = "Globally unique name for the Azure Storage Account (3–24 lowercase letters/numbers)"
  type        = string
  default     = "projectstoragedemo"
}

variable "diagnostic_setting" {
  description = "Configuration for diagnostic settings"
  type = object({
    name                        = string
    resource_type               = string
    resource_ref                = string
    resource_lz_key             = optional(string)
    storage_account_ref         = optional(string)
    storage_account_lz_key      = optional(string)
    log_analytics_workspace_ref = optional(string)
    log_analytics_lz_key        = optional(string)
    logs = optional(map(object({
      category         = string
      enabled          = bool
      retention_policy = optional(object({
        enabled = bool
        days    = number
      }))
    })))
    metrics = optional(map(object({
      category         = string
      enabled          = bool
      retention_policy = optional(object({
        enabled = bool
        days    = number
      }))
    })))
  })
}

