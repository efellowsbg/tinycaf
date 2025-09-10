module "log_analytics_workspaces" {
  source   = "./modules/log_analytics_workspace"
  for_each = var.log_analytics_workspaces

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups    = module.resource_groups
        managed_identities = module.managed_identities
        storage_accounts   = module.storage_accounts
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
