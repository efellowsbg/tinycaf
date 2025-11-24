variable "subscription_assignments" {
  description = "Map of built-in role name to list of user UPNs or service principal object IDs"
  type        = map(list(string))
}

variable "global_settings" {
  description = "Global settings for tinycaf"
}

data "azurerm_client_config" "current" {}

locals {
  # Build a flat list: "<role>_<identifier>" => { role = "...", user = "..." }
  flat_assignments = merge([
    for role, users in var.subscription_assignments : {
      for user in users : "${role}_${user}" => {
        role = role
        user = user
      }
    }
  ]...)
}

# Lookup Azure AD user by UPN only (skip GUIDs)
data "azuread_user" "users" {
  for_each = {
    for assignment in local.flat_assignments :
    assignment.user => assignment.user
    if !can(regex("^[0-9a-fA-F-]{36}$", assignment.user))
  }

  user_principal_name = each.value
}

# Lookup service principal by GUID
data "azuread_service_principal" "sps" {
  for_each = {
    for assignment in local.flat_assignments :
    assignment.user => assignment.user
    if can(regex("^[0-9a-fA-F-]{36}$", assignment.user))
  }

  object_id = each.value
}

resource "azurerm_role_assignment" "assignments" {
  for_each = local.flat_assignments

  principal_id = try(
    data.azuread_user.users[each.value.user].object_id,
    data.azuread_service_principal.sps[each.value.user].object_id
  )

  role_definition_name = each.value.role
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
}
