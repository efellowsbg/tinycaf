resource "azurerm_role_assignment" "main" {
  # Flatten the role assignments structure into a map
  for_each = tomap(flatten([
    for resource_type, roles in var.role_assignments.built_in_roles : [
      for role_definition_name, resources in roles : [
        for resource_key, resource_details in resources : [
          for principal_key, principal_list in resource_details : [
            for principal in try(principal_list, []) : {
              resource_type       = resource_type
              role_definition_name = role_definition_name
              resource_key         = resource_key
              principal_type       = principal_key
              principal            = principal
            }
          ]
        ]
      ]
    ]
  ]))

  # Dynamically resolve the scope
  scope = try(var.resources[each.value.resource_type][each.value.resource_key].id, null)

  # Dynamically resolve the principal_id based on the principal type and key
  principal_id = try(var.resources[each.value.principal_type][each.value.principal].id, null)

  # Role definition
  role_definition_name = each.value.role_definition_name
}
