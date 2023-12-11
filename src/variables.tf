variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string))
  }))
  default = {}
}

variable "managed_identities" {
  type = map(object({
    name               = string,
    resource_group_ref = optional(string),
    resource_group = optional(object({
      ref       = string,
      state_ref = string,
    })),
    tags = optional(map(string))
  }))
  default = {}

  # TODO: validation on ref
}

variable "config" {
  type = object({
    state_file = string,
    container  = optional(string),
    remote_states = optional(map(object({
      state_file = string,
      container  = optional(string),
    })))
  })

  validation {
    condition     = endswith(var.config.state_file, ".tfstate")
    error_message = "State file must end with .tfstate"
  }

  validation {
    condition     = alltrue([for _, config in coalesce(var.config.remote_states, {}) : config.container == null && var.config.container == null ? config.state_file != var.config.state_file : config.container != var.config.container])
    error_message = "You may not refer to a state file in the same container (potential cycles)."
  }
}

variable "users" { default = {} }
