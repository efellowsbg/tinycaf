module "managed_identities" {
  source   = "./modules/managed_identity"
  for_each = var.managed_identities

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}
