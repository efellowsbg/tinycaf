module "built_in_roles" {
  source = "./built_in_roles"

  for_each = {
    for resource_type, roles in try(var.settings, {}) :
    resource_type => {
      resource_type = resource_type
      roles         = roles
    }
  }
  settings        = each.value.roles    # Pass the roles for the current resource type
  resource_type   = each.value.resource_type    # Pass the resource type dynamically
  global_settings = var.global_settings
  resources       = var.resources
}
