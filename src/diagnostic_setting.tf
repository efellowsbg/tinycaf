module "diagnostic_settings" {
  source          = "./modules/diagnostic_setting"
  for_each        = var.diagnostic_settings
  settings        = each.value
  global_settings = var.global_settings

  resources = merge(
    {
      (var.landingzone.key) = {
        keyvaults                = module.keyvaults
        log_analytics_workspaces = module.log_analytics_workspaces
        storage_accounts         = module.storage_accounts
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
