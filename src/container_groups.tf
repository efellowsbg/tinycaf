module "container_groups" {
  source   = "./modules/container_group"
  for_each = var.container_groups

  settings        = each.value
  global_settings = local.global_settings

  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups          = module.resource_groups
        virtual_networks         = module.virtual_networks
        managed_identities       = module.managed_identities
        key_vault_keys           = module.key_vault_keys
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
