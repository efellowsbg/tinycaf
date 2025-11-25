variable "subscription_assignments" {
  description = "Map of built-in role name to list of user UPNs or service principal object IDs"
  type        = map(list(string))
}

variable "global_settings" {
  description = "Global settings for tinycaf"
}

data "azurerm_client_config" "current" {}

locals {
  # Build a flat list: "<role>_<principal>" => { role = "...", principal = "..." }
  flat_assignments = merge([
    for role, principals in var.subscription_assignments : {
      for principal in principals :
      "${role}_${principal}" => {
        role      = role
        principal = principal
      }
    }
  ]...)
}

# Lookup Azure AD users (UPNs)
data "azuread_user" "users" {
  for_each = {
    for _, assignment in local.flat_assignments :
    assignment.principal => assignment.principal
    if !can(regex("^[0-9a-fA-F-]{36}$", assignment.principal))
  }

  user_principal_name = each.value
}

# Lookup service principals (GUIDs)
data "azuread_service_principal" "sps" {
  for_each = {
    for _, assignment in local.flat_assignments :
    assignment.principal => assignment.principal
    if can(regex("^[0-9a-fA-F-]{36}$", assignment.principal))
  }

  object_id = each.value
}

resource "azurerm_role_assignment" "assignments" {
  for_each = local.flat_assignments

  principal_id = try(
    data.azuread_user.users[each.value.principal].object_id,
    data.azuread_service_principal.sps[each.value.principal].object_id
  )

  role_definition_name = each.value.role
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
}
