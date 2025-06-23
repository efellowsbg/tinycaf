locals {
  computed_role_assignments = tomap({
    for item in flatten([
      for role_definition_name, resources in var.settings : [
        for resource_key, resource_details in resources : [
          for principal_type, principals in try(resource_details, {}) : [
            for principal in (
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
    "${item.role_definition_name}-${item.resource_key}-${item.principal_type}-${item.principal}" => item
  })
}
