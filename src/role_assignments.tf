module "role_assignments" {
  source   = "./modules/role_assignments"
  for_each = var.role_assignments

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups   = module.resource_groups
    keyvaults         = module.keyvaults
    managed_identities = module.managed_identities
  }
}
