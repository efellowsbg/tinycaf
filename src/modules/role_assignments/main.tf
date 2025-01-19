module "built_in_roles" {
  source = "./built_in_roles"

  for_each = {
    for resource_type, roles in try(var.role_assignments.built_in_roles, {}) : resource_type => {
      resource_type = resource_type
      roles         = roles
    }
  }

  settings        = each.value
  global_settings = var.global_settings
  resources       = var.resources
}
