module "logic_apps_standard" {
  source   = "./modules/logic_app/standard"
  for_each = var.logic_apps_standard

  settings        = each.value
  global_settings = local.global_settings


  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups    = module.resource_groups
        app_service_plans  = module.app_service_plans
        storage_accounts   = module.storage_accounts
        managed_identities = module.managed_identities
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

module "logic_apps_workflow" {
  source   = "./modules/logic_app/workflow"
  for_each = var.logic_apps_workflow

  settings        = each.value
  global_settings = local.global_settings


  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups    = module.resource_groups
        managed_identities = module.managed_identities
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
