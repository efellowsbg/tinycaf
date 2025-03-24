module "app_service_plans" {
  source   = "./modules/app_service_plan"
  for_each = var.app_service_plans

  settings        = each.value
  global_settings = local.global_settings
  resources = {
    resource_groups = module.resource_groups
  }
}
