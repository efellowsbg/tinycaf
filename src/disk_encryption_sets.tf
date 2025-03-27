module "disk_encryption_sets" {
  source   = "./modules/disk_encryption_set"
  for_each = var.disk_encryption_sets

  settings        = each.value
  global_settings = local.global_settings
  resources = {
    resource_groups    = module.resource_groups
    key_vault_keys     = module.key_vault_keys
    managed_identities = module.managed_identities
  }
}
