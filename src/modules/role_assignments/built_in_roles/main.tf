resource "azurerm_role_assignment" "main" {
  for_each = tomap(flatten([
    for role_definition_name, resources in var.settings : [
      for resource_key, resource_details in resources : [
        for principal_type, principals in try(resource_details, {}) : [
          for principal in principals : {
            role_definition_name = role_definition_name
            resource_key         = resource_key
            resource_type        = var.resource_type # Passed dynamically
            principal_type       = principal_type
            principal            = principal
          }
        ]
      ]
    ]
  ]))

  # Resolve the scope dynamically
  scope = try(var.resources[each.value.resource_type][each.value.resource_key].id, null)

  # Resolve principal_id dynamically
  principal_id = try(var.resources[each.value.principal_type][each.value.principal].id, null)

  role_definition_name = each.value.role_definition_name
}
