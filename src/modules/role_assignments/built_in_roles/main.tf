resource "azurerm_role_assignment" "main" {
  for_each = tomap({
    # Iterate through the resources and create a map for all roles
    for item in flatten([
      for role_definition_name, resources in var.settings : [
        for resource_key, resource_details in resources : [
          for principal_type, principals in try(resource_details, {}) : [
            for principal in principals : {
              role_definition_name = role_definition_name
              resource_key         = resource_key
              resource_type        = var.resource_type
              principal_type       = principal_type
              principal            = principal
            }
          ]
        ]
      ]
    ]) :
    # Generate keys dynamically, include object_ids logic
    "${item.role_definition_name}-${item.resource_key}-${item.principal_type}-${item.principal}" => item
  })

  scope = try(
    var.resources[each.value.resource_type][each.value.resource_key].id,
    null
  )

  principal_id = try(
    # If the resource_key is "object_ids", assign the list directly
    each.value.resource_key == "object_ids"
      ? join(",", each.value.principal)
      : var.resources[each.value.principal_type][each.value.principal].id,
    null
  )

  role_definition_name = each.value.role_definition_name
}
