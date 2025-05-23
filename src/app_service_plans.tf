module "app_service_plans" {
  source   = "./modules/app_service_plan"
  for_each = var.app_service_plans

  settings        = each.value
  global_settings = local.global_settings
  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups    = module.resource_groups
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

