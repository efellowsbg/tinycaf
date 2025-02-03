resource "azurerm_role_assignment" "main" {
  for_each = tomap({
    for item in flatten([
      for role_definition_name, resources in var.settings : [
        for resource_key, resource_details in resources : [
          for principal_type, principals in try(resource_details, {}) : [
            for principal in(
              # Handle cases where the principal is a list (like object_ids) or a single value
              can(principals) && length(principals) > 0 ? principals : []
              ) : {
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
    # Ensure unique keys for each role assignment
    "${item.role_definition_name}-${item.resource_key}-${item.principal_type}-${item.principal}" => item
  })

  scope = try(
    var.resources[each.value.resource_type][each.value.resource_key].id,
    null
  )

  principal_id = try(
    # If principal is directly an ID (like object_ids), use it. Otherwise, resolve via var.resources.
    each.value.principal_type == "object_ids"
    ? each.value.principal
    : var.resources[each.value.principal_type][each.value.principal].principal_id,
    null
  )

  role_definition_name = each.value.role_definition_name
}


# resource "azurerm_role_assignment" "main" {
#   name               = var.settings.name
#   scope              = data.azurerm_subscription.primary.id
#   role_definition_id = azurerm_role_definition.example.role_definition_resource_id
#   principal_id       = var.settings.principal_id

#   principal_type                         = try(var.settings.principal_type, null)
#   condition                              = try(var.settings.condition, null)
#   condition_version                      = try(var.settings.condition_version, null)
#   delegated_managed_identity_resource_id = try(var.settings.delegated_managed_identity_resource_id, null)
#   description                            = try(var.settings.description, null)
#   skip_service_principal_aad_check       = try(var.settings.skip_service_principal_aad_check, null)

#   dynamic "timeouts" {
#     for_each = try(var.settings.timeouts[*], {})

#     content {
#       read   = try(timeouts.value.read, null)
#       create = try(timeouts.value.create, null)
#       delete = try(timeouts.value.delete, null)
#     }
#   }
# }
