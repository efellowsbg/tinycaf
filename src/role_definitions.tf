module "role_definitions" {
  source   = "./modules/role_definitions"
  for_each = var.role_definitions

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}
