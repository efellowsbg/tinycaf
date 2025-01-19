module "built_in_roles" {
  source = "./built_in_roles"

  for_each = {
    for resource_type, roles in try(var.settings.built_in_roles, {}) :
    resource_type => {
      resource_type = resource_type
      roles         = roles
    }
  }
  new_settings = var.settings
  settings        = each.value.roles
  resource_type   = each.value.resource_type
  global_settings = var.global_settings
  resources       = var.resources
}
