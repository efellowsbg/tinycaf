data "azuread_group" "by_name" {
  for_each = {
    for k, v in local.computed_role_assignments :
    k => v
    if v.principal_type == "group_names"
  }

  display_name = each.value.principal
}
