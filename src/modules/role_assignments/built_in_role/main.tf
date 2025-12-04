resource "azurerm_role_assignment" "main" {
  for_each = tomap({
    for item in local.flat_assignments :
    "${item.role_definition_name}-${item.resource_key}-${item.principal_type}-${item.principal}" => item
  })

  scope = try(
    var.resources[
      try(var.settings.lz_key, var.client_config.landingzone_key)
      ].virtual_networks[
      split("/", each.value.resource_key)[0]
      ].subnets[
      split("/", each.value.resource_key)[1]
    ].id,
    var.resources[
      try(var.settings.lz_key, var.client_config.landingzone_key)
    ][var.resource_type][each.value.resource_key].id,
    null
  )

  principal_id = try(
    # 1) Existing: direct object IDs
    each.value.principal_type == "object_ids"
    ? each.value.principal

    # 2) NEW: users resolved from email/UPN
    : each.value.principal_type == "users_email"
    ? data.azuread_user.users[each.value.principal].id

    # 3) NEW: groups resolved from display_name
    : each.value.principal_type == "group_name"
    ? data.azuread_group.groups[each.value.principal].id

    # 4) Existing: resolve from var.resources (managed identities, etc.)
    : var.resources[
      try(var.settings.lz_key, var.client_config.landingzone_key)
    ][each.value.principal_type][each.value.principal].principal_id,
    null
  )

  role_definition_name = each.value.role_definition_name
}

data "azuread_user" "users" {
  for_each            = local.users_email
  user_principal_name = each.value
}

data "azuread_group" "groups" {
  for_each     = local.group_names
  display_name = each.value
}
