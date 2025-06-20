resource "azurerm_monitor_diagnostic_setting" "main" {
  name               = var.diagnostic_setting.name
  target_resource_id = var.resources[
    try(var.diagnostic_setting.resource_lz_key, var.client_config.landingzone_key)
  ][var.diagnostic_setting.resource_type][var.diagnostic_setting.resource_ref].id

  dynamic "log" {
    for_each = try(var.diagnostic_setting.logs, {})
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
    for_each = try(var.diagnostic_setting.metrics, {})
    content {
      category = metric.value.category
      enabled  = metric.value.enabled

    }
  }

  # Only include if log_analytics_workspace_ref is not null
  log_analytics_workspace_id = (
    try(var.diagnostic_setting.log_analytics_workspace_ref, null) != null ?
    var.resources[
      try(var.diagnostic_setting.log_analytics_lz_key, var.client_config.landingzone_key)
    ].log_analytics[var.diagnostic_setting.log_analytics_workspace_ref].id :
    null
  )

  # Only include if storage_account_ref is not null
  storage_account_id = (
    try(var.diagnostic_setting.storage_account_ref, null) != null ?
    var.resources[
      try(var.diagnostic_setting.storage_account_lz_key, var.client_config.landingzone_key)
    ].storage_accounts[var.diagnostic_setting.storage_account_ref].id :
    null
  )
}
