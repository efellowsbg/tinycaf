module "log_analytics_data_export_rules" {
  source   = "./modules/log_analytics_data_export_rule"
  for_each = var.log_analytics_data_export_rules

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups          = module.resource_groups
    storage_accounts         = module.storage_accounts
    log_analytics_workspaces = module.log_analytics_workspaces
  }
}
