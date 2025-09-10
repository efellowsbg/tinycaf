resource "azurerm_monitor_diagnostic_setting" "main" {
  name = var.settings.name
  target_resource_id = var.resources[
    try(var.settings.target_lz_key, var.client_config.landingzone_key)
  ][var.settings.target_resource_type][var.settings.target_resource_ref].id
  log_analytics_workspace_id = local.log_analytics_workspace_id
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
