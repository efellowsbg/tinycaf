# TODO: location abstraction map
# TODO: custom / overridable abstraction map

provider "azurerm" {
  features {}
}

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

data "terraform_remote_state" "remote" {
  for_each = coalesce(var.config.remote_states, {})

  # TODO: add support for azure, when `each.value.container` is set
  backend = "local"
  config = {
    path = each.value.state_file
  }
}

locals {
  objects = {
    resource_groups    = azurerm_resource_group.main
    managed_identities = azurerm_user_assigned_identity.main
  }
  ref = trimsuffix(var.config.state_file, ".tfstate")

  remote_objects         = { for state_ref, remote in data.terraform_remote_state.remote : state_ref => remote.outputs.objects }
  remote_resource_groups = { for state_ref, remote in local.remote_objects : state_ref => remote.resource_groups }
  all_resource_groups    = merge({ (local.ref) = azurerm_resource_group.main }, local.remote_resource_groups)
}

resource "azurerm_resource_group" "main" {
  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location
  tags     = try(each.value.tags, null)
}

resource "azurerm_user_assigned_identity" "main" {
  for_each = var.managed_identities

  name                = each.value.name
  resource_group_name = local.all_resource_groups[try(each.value.resource_group.state_ref, local.ref)][try(each.value.resource_group.ref, each.value.resource_group_ref)].name
  location            = local.all_resource_groups[try(each.value.resource_group.state_ref, local.ref)][try(each.value.resource_group.ref, each.value.resource_group_ref)].location
}

output "objects" {
  value = local.objects
}
