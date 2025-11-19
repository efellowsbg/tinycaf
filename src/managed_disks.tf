module "managed_disks" {
  source   = "./modules/managed_disk"
  for_each = var.managed_disks

  settings        = each.value
  global_settings = local.global_settings

  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups  = module.resource_groups
        keyvaults        = module.keyvaults
        storage_accounts = module.storage_accounts
        key_vault_keys   = module.key_vault_keys
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
