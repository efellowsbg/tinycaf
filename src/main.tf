# TODO: location abstraction map
# TODO: custom / overridable abstraction map

provider "azurerm" {
  features {}
}

locals {
  ref = trimsuffix(var.config.state_file, ".tfstate")
}

data "terraform_remote_state" "remote" {
  for_each = coalesce(var.config.remote_states, {})

  backend = can(each.value.container) ? "remote" : "local"
  config = can(each.value.container) ? {
    # TODO: use a separate settings landingzone, or allow setting them explicitly
    resource_group_name  = "rg-shd-infra"
    storage_account_name = "stshdeflinfra"
    container_name       = each.value.container
    key                  = each.value.state_file
  } : { path = each.value.state_file }
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

module "users" {
  source   = "./modules/user"
  for_each = var.users

  ref      = each.key
  settings = each.value
}

output "objects" {
  value = local.objects
}
