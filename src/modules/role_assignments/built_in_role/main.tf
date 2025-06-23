resource "azurerm_role_assignment" "main" {
  for_each = local.computed_role_assignments

  scope = try(
    var.resources[each.value.resource_type][each.value.resource_key].id,
    null
  )

  principal_id = try(
    each.value.principal_type == "object_ids"
    ? each.value.principal :
    each.value.principal_type == "group_names"
    ? data.azuread_group.by_name.object_id :
    var.resources[each.value.principal_type][each.value.principal].principal_id,
    null
  )

  role_definition_name = each.value.role_definition_name
}
