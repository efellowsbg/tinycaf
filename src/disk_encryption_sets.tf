module "disk_encryption_sets" {
  source   = "./modules/disk_encryption_set"
  for_each = var.disk_encryption_sets

  settings        = each.value
  global_settings = local.global_settings

  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups    = module.resource_groups
        key_vault_keys     = module.key_vault_keys
        managed_identities = module.managed_identities
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

