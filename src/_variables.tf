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



