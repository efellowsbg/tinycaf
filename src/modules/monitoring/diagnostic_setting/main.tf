resource "azurerm_monitor_diagnostic_setting" "main" {
  name = var.diagnostic_setting.name

  target_resource_id = var.resources[
    try(var.diagnostic_setting.resource_lz_key, var.client_config.landingzone_key)
  ][var.diagnostic_setting.resource_type][var.diagnostic_setting.resource_ref].id

  dynamic "log" {
    for_each = try(var.diagnostic_setting.logs, {})
    content {
      category = log.value.category
      enabled  = log.value.enabled

    }
  }

  dynamic "metric" {
    for_each = try(var.diagnostic_setting.metrics, {})
    content {
      category = metric.value.category
      enabled  = metric.value.enabled

    }
  }

  dynamic "log_analytics_workspace_id" {
    for_each = try(var.diagnostic_setting.log_analytics_workspace_ref, null) != null ? [1] : []
    content {
      workspace_id = var.resources[
        try(var.diagnostic_setting.log_analytics_lz_key, var.client_config.landingzone_key)
      ].log_analytics[var.diagnostic_setting.log_analytics_workspace_ref].id
    }
  }

  dynamic "storage_account_id" {
    for_each = try(var.diagnostic_setting.storage_account_ref, null) != null ? [1] : []
    content {
      storage_account_id = var.resources[
        try(var.diagnostic_setting.storage_account_lz_key, var.client_config.landingzone_key)
      ].storage_accounts[var.diagnostic_setting.storage_account_ref].id
    }
  }
}
