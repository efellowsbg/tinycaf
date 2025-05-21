module "function_apps" {
  source   = "./modules/function_apps"
  for_each = var.function_apps

  settings        = each.value
  global_settings = var.global_settings

  resources = {
    resource_groups      = module.resource_groups
    virtual_networks     = module.virtual_networks
    keyvaults            = module.keyvaults
    app_service_plans = module.app_service_plans
    storage_accounts     = module.storage_accounts
  }
}
