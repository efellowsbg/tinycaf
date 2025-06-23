data "azuread_group" "by_name" {
  for_each     = local.group_names
  display_name = each.key
}

data "azuread_user" "by_name" {
  for_each            = local.user_names
  user_principal_name = each.key
}

locals {
  group_names = toset([
    for ra in local.computed_role_assignments : ra.principal
    if ra.principal_type == "group_names"
  ])

  user_names = toset([
    for ra in local.computed_role_assignments : ra.principal
    if ra.principal_type == "user_names"
  ])
}
