module "log_analytics_data_export_rules" {
  source   = "./modules/log_analytics_data_export_rule"
  for_each = var.log_analytics_data_export_rules

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups          = module.resource_groups
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

