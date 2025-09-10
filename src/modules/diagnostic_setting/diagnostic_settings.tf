resource "azurerm_monitor_diagnostic_setting" "main" {
  name                       = var.settings.name
  target_resource_id         = var.resource_id
  log_analytics_workspace_id = local.log_analytics_workspace_id
  # storage_account_id         = local.storage_account_id
  dynamic "enabled_log" {
    for_each = try(var.settings.logs, {})
    content {
      category = enabled_log.value.category
    }
  }
  dynamic "enabled_metric" {
    for_each = try(var.settings.metrics, {})
    content {
      category = enabled_metric.value.category
    }
  }
}
