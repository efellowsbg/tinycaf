output "subscription_assignments" {
  value = {
    for key, assignment in azurerm_role_assignment.assignments :
    key => {
      principal_id = assignment.principal_id

      user_principal_name = (
        contains(keys(data.azuread_user.users), local.flat_assignments[key].user)
        ? data.azuread_user.users[local.flat_assignments[key].user].user_principal_name
        : null
      )
    }
  }
}
