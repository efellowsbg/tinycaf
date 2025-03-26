module "logic_apps_standard" {
  source   = "./modules/logic_app/standard"
  for_each = var.logic_apps_standard

  settings        = each.value
  global_settings = local.global_settings
  resources = {
    resource_groups    = module.resource_groups
    app_service_plans  = module.app_service_plans
    storage_accounts   = module.storage_accounts
    managed_identities = module.managed_identities
  }
}
