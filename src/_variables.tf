variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "client_config" {
  default = {}
}

variable "logged_user_objectId" {
  description = "Used to set access policies based on the value 'logged_in_user'. Can only be used in interactive execution with vscode."
  type        = string
  default     = null
}

variable "logged_aad_app_objectId" {
  description = "Used to set access policies based on the value 'logged_in_aad_app'"
  type        = string
  default     = null
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
