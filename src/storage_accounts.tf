module "storage_accounts" {
  for_each = var.storage_accounts
  source   = "./modules/storage_account"

  settings        = each.value
  global_settings = var.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups    = module.resource_groups
        virtual_networks   = module.virtual_networks
        private_dns_zones  = module.private_dns_zones
        managed_identities = module.managed_identities
        key_vault_keys     = module.key_vault_keys
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
