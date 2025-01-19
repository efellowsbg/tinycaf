module "built_in_roles" {
  source          = "./built_in_roles"
  for_each        = try(var.settings.built_in_roles, {})
  settings        = each.value
  global_settings = var.global_settings
  resources       = var.resources
}
