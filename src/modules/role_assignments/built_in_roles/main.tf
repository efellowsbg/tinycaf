resource "azurerm_role_assignment" "main" {
  for_each = tomap(flatten([
    for resource_type, roles in try(var.settings.built_in_roles, {}) : [
      for role_definition_name, resources in try(roles, {}) : [
        for resource_key, resource_details in try(resources, {}) : [
          for principal in try(resource_details.managed_identities, []) : {
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
