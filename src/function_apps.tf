module "function_apps" {
  source   = "./modules/function_app"
  for_each = var.function_apps

  settings        = each.value
  global_settings = var.global_settings


  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups   = module.resource_groups
        virtual_networks  = module.virtual_networks
        keyvaults         = module.keyvaults
        app_service_plans = module.app_service_plans
        storage_accounts  = module.storage_accounts
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
