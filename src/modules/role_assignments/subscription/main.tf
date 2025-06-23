variable "subscription_assignments" {
  description = "Map of built-in role name to list of user UPNs"
  type        = map(list(string))
}

variable "global_settings" {
  description = "Global settings for tinycaf"
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

resource "azurerm_role_assignment" "assignments" {
  for_each = local.flat_assignments

  principal_id         = data.azuread_user.users[each.value.user].object_id
  role_definition_name = each.value.role
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
}


data "azuread_group" "test" {
  display_name     = "Dev_Owners"
  security_enabled = true
}