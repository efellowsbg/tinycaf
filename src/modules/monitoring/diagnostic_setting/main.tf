resource "azurerm_monitor_diagnostic_setting" "main" {
  name = var.settings.name

  target_resource_id = var.resources[
    try(var.settings.resource_lz_key, var.client_config.landingzone_key)
  ][var.settings.resource_type][var.settings.resource_ref].id

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

    }
  }

  dynamic "log_analytics_workspace_id" {
    for_each = try(var.settings.log_analytics_workspace_ref, null) != null ? [1] : []
    content {
      workspace_id = var.resources[
        try(var.settings.log_analytics_lz_key, var.client_config.landingzone_key)
      ].log_analytics[var.settings.log_analytics_workspace_ref].id
    }
  }

  dynamic "storage_account_id" {
    for_each = try(var.settings.storage_account_ref, null) != null ? [1] : []
    content {
      storage_account_id = var.resources[
        try(var.settings.storage_account_lz_key, var.client_config.landingzone_key)
      ].storage_accounts[var.settings.storage_account_ref].id
    }
  }
}
