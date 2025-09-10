resource "azurerm_monitor_diagnostic_setting" "this" {
  name                = var.settings.name
  target_resource_id  = var.resource_id
  log_analytics_workspace_id = var.settings.log_analytics_workspace_id
  storage_account_id = var.settings.storage_account_id
  logs               = var.settings.logs
  metrics            = var.settings.metrics
  tags               = local.tags
}