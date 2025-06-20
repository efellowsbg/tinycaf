resource "azurerm_monitor_diagnostic_setting" "main" {
  name               = var.settings.name
  target_resource_id = var.settings.target_resource_id

  dynamic "log" {
    for_each = try(var.settings.logs, {})
    content {
      category = log.value.category
      enabled  = log.value.enabled

      retention_policy {
        enabled = try(log.value.retention_policy.enabled, false)
        days    = try(log.value.retention_policy.days, 0)
      }
    }
  }

  dynamic "metric" {
    for_each = try(var.settings.metrics, {})
    content {
      category = metric.value.category
      enabled  = metric.value.enabled

      retention_policy {
        enabled = try(metric.value.retention_policy.enabled, false)
        days    = try(metric.value.retention_policy.days, 0)
      }
    }
  }

  dynamic "log_analytics_workspace_id" {
    for_each = try(var.settings.log_analytics_workspace_id, null) != null ? [1] : []
    content {
      workspace_id = var.settings.log_analytics_workspace_id
    }
  }

  dynamic "storage_account_id" {
    for_each = try(var.settings.storage_account_id, null) != null ? [1] : []
    content {
      storage_account_id = var.settings.storage_account_id
    }
  }
}
