resource "azurerm_role_assignment" "main" {
  for_each = tomap(flatten([
    for resource_type, roles in var.settings.built_in_roles : [
      for role_definition_name, resources in roles : [
        for resource_key, resource_details in resources : [
          for principal in try(resource_details.principals, []) : {
            resource_type       = resource_type
            role_definition_name = role_definition_name
            resource_key         = resource_key
            principal            = principal
          }
        ]
      ]
    ]
  ]))

  scope = try(var.resources[each.value.resource_type][each.value.resource_key].id, null)

  principal_id = try(var.resources.managed_identities[each.value.principal].id, null)

  role_definition_name = each.value.role_definition_name
}
