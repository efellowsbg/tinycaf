module "postgresql_flexible_server" {
  source          = "./modules/postgresql_flexible_server"
  for_each        = var.postgresql_flexible_servers
  settings        = each.value
  global_settings = local.global_settings

  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups         = module.resource_groups
        managed_identities      = module.managed_identities
        virtual_networks        = module.virtual_networks
        private_dns_zones       = module.private_dns_zones
        keyvkey_vault_keysaults = module.key_vault_keys
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
