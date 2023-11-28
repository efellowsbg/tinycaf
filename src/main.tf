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

  # TODO: validation on keys
  # TODO: validation on ref
}

variable "state_ref" {
  type = string
}

variable "remote_states" {
  type    = map(string)
  default = {}
}

data "terraform_remote_state" "remote" {
  for_each = var.remote_states

  backend = "local"
  config = {
    path = each.value
  }
}

locals {
  # object_types = distinct(flatten([for state_ref, remote in data.terraform_remote_state.remote : keys(remote.outputs.objects)]))
  objects = {
    resource_groups    = azurerm_resource_group.main
    # managed_identities = azurerm_user_assigned_identity.main
  }
  # object_types = keys(local.objects)
  # remote_objects = {
  #   for object_type in local.object_types : object_type => {
  #     for state_ref, remote in data.terraform_remote_state.remote :
  #     state_ref => remote.outputs.objects[object_type]
  #   }
  # }
  remote_objects         = { for state_ref, remote in data.terraform_remote_state.remote : state_ref => remote.outputs.objects }
  remote_resource_groups = { for state_ref, remote in local.remote_objects : state_ref => remote.resource_groups }
  all_resource_groups    = merge({ (var.state_ref) = azurerm_resource_group.main }, local.remote_resource_groups)
  # all = {
  #   for object_type in local.object_types : object_type => merge(
  #     { (var.state_ref) = local.objects[object_type] },
  #     local.remote_objects[object_type],
  #   )
  # }

  # all_resource_groups = merge({
  #   (var.state_ref) = azurerm_resource_group.main },
  #   { for state_ref, objects in local.remote_objects : state_ref => objects.resource_groups }
  # )
}

# output "remote_test" {
#   value = local.remote_objects
# }

resource "azurerm_resource_group" "main" {
  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location
  tags     = try(each.value.tags, null)
}

resource "azurerm_user_assigned_identity" "main" {
  for_each = var.managed_identities

  name = each.value.name
  resource_group_name = local.all_resource_groups[try(each.value.resource_group.state_ref, var.state_ref)][try(each.value.resource_group.ref, each.value.resource_group_ref)].name
  location            = local.all_resource_groups[try(each.value.resource_group.state_ref, var.state_ref)][try(each.value.resource_group.ref, each.value.resource_group_ref)].location
}

output "objects" {
  value = local.objects
}
