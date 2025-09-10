module "keyvaults" {
  source   = "./modules/keyvault"
  for_each = var.keyvaults

  settings        = each.value
  global_settings = local.global_settings
  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups          = module.resource_groups
        virtual_networks         = module.virtual_networks
        managed_identities       = module.managed_identities
        private_dns_zones        = module.private_dns_zones
        azuread_applications     = module.azuread_applications
        storage_accounts         = module.storage_accounts
        log_analytics_workspaces = module.log_analytics_workspaces
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
