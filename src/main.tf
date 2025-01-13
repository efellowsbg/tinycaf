module "resource_groups" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  settings        = each.value
  global_settings = var.global_settings
}

module "managed_identities" {
  source   = "./modules/managed_identity"
  for_each = var.managed_identities

  settings        = each.value
  global_settings = var.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}
