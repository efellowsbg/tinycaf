module "built_in_roles" {
  source          = "./built_in_roles"

  # Flatten the structure and include parent keys in the iteration
  for_each = tomap(flatten([
    for resource_type, roles in try(var.settings.built_in_roles, {}) : [
      for role, kv_refs in roles : {
        resource_type       = resource_type
        role_definition_name = role
        keyvaults           = kv_refs
      }
    ]
  ]))

  settings        = each.value
  global_settings = var.global_settings
  resources       = var.resources
}
