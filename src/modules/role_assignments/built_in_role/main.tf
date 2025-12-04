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
    each.value.principal_type == "object_ids"
    ? each.value.principal

    : each.value.principal_type == "users_email"
    ? data.azuread_user.users[each.value.principal].object_id

    : each.value.principal_type == "group_name"
    ? data.azuread_group.groups[each.value.principal].object_id


    : var.resources[
      can(regex("/", each.value.principal))
      ? split("/", each.value.principal)[0]
      : try(var.settings.lz_key, var.client_config.landingzone_key)
      ][each.value.principal_type][
      can(regex("/", each.value.principal))
      ? split("/", each.value.principal)[1]
      : each.value.principal
    ].principal_id,
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
