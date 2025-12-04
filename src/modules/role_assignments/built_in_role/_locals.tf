locals {
  # Exactly your original flatten logic – NO var.resources, NO filtering
  flat_assignments = flatten([
    for role_definition_name, resources in var.settings : [
      for resource_key, resource_details in resources : [
        for principal_type, principals in try(resource_details, {}) : [
          for principal in(
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
  ])

  # Distinct user emails (UPNs)
  users_email = {
    for a in local.flat_assignments :
    a.principal => a.principal
    if a.principal_type == "users_email"
    && !can(regex("^[0-9a-fA-F-]{36}$", a.principal))
  }

  # Distinct group display names
  group_names = {
    for a in local.flat_assignments :
    a.principal => a.principal
    if a.principal_type == "group_name"
  }
}
