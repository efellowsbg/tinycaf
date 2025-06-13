variable "subscription_assignments" {
  description = "Map of built-in role name to list of user UPNs"
  type        = map(list(string))
}

data "azurerm_client_config" "current" {}

locals {
  flat_assignments = merge([
    for role, users in var.subscription_assignments : {
      for user in users : "${role}_${user}" => {
        role = role
        user = user
      }
    }
  ]...)
}

# Lookup Azure AD user by UPN
data "azuread_user" "users" {
  for_each = {
    for assignment in local.flat_assignments : assignment.user => assignment.user
  }

  user_principal_name = each.value
}

# Lookup built-in role definition by name (e.g., "Contributor", "Reader")
data "azurerm_role_definition" "built_in" {
  for_each = {
    for assignment in local.flat_assignments : assignment.role => assignment.role
  }

  name  = each.key
  scope = "/"
}

resource "azurerm_role_assignment" "assignments" {
  for_each = local.flat_assignments

  principal_id = data.azuread_user.users[each.value.user].object_id
  role_definition_id = data.azurerm_role_definition.built_in[each.value.role].id
  scope              = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
}
