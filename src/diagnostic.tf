module "diagnostic_setting" {
  source   = "./modules/monitoring/diagnostic_setting"
  for_each = var.diagnostic_settings


  diagnostic_setting = each.value
  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups    = module.resource_groups 
        storage_accounts = module.storage_accounts
        log_analytics = module.log_analytics       
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  global_settings = local.global_settings

  client_config = {
    landingzone_key = var.landingzone.key
  }
}
