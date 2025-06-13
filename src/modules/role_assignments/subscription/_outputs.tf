output "subscription_assignments" {
  description = "Mapping of users to built-in role assignments at the subscription scope"
  value = {
    for key, assignment in azurerm_role_assignment.assignments :
    key => {
      user_principal_name = assignment.principal_id != "" ? data.azuread_user.users[local.flat_assignments[key].user].user_principal_name : null
      role                = local.flat_assignments[key].role
      role_assignment_id  = assignment.id
      scope               = assignment.scope
    }
  }
}