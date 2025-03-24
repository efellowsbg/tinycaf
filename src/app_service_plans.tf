module "resource_groups" {
  source   = "./modules/app_service_plan"
  for_each = var.app_service_plans

  settings        = each.value
  global_settings = local.global_settings
}
