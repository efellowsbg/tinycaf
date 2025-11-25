output "subscription_assignments" {
  description = "Resolved subscription-level role assignments"

  value = {
    for key, assignment in azurerm_role_assignment.assignments :
    key => {
      role         = local.flat_assignments[key].role
      principal_id = assignment.principal_id

      # UPN only when principal is a user (non-GUID)
      user_principal_name = (
        contains(keys(data.azuread_user.users), local.flat_assignments[key].principal)
        ? data.azuread_user.users[local.flat_assignments[key].principal].user_principal_name
        : null
      )
    }
  }
}
