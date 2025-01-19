resource "azurerm_role_assignment" "main" {
  for_each = tomap(flatten([
    for resource_type, roles in var.settings : [
      for role_definition_name, resources in roles : [
        for resource_key, resource_details in resources : [
          for principal_type, principals in try(resource_details, {}) : [
            for principal in principals : {
              role_definition_name = role_definition_name
              resource_key         = resource_key
              resource_type        = resource_type # Derived dynamically
              principal_type       = principal_type # Dynamic principal type (e.g., "managed_identities")
              principal            = principal
            }
          ]
        ]
      ]
    ]
  ]))

  # Dynamically resolve the scope using resource_type and resource_key
  scope = try(var.resources[each.value.resource_type][each.value.resource_key].id, null)

  # Dynamically resolve principal_id using principal_type and principal
  principal_id = try(var.resources[each.value.principal_type][each.value.principal].id, null)

  role_definition_name = each.value.role_definition_name
}
