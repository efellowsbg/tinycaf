module "log_analytics_workspaces" {
  source   = "./modules/log_analytics_workspace"
  for_each = var.log_analytics_workspaces

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups                 = module.resource_groups
    managed_identities              = module.managed_identities
    log_analytics_data_export_rules = module.log_analytics_data_export_rules
    storage_accounts                = module.storage_accounts
  }
}
