resource "azurerm_monitor_diagnostic_setting" "main" {


  name               = var.settings.name
  target_resource_id = var.resources[
    try(var.settings.resource_lz_key, var.client_config.landingzone_key)
  ][var.settings.resource_type][var.settings.resource_ref].id

  dynamic "enabled_log" {
    for_each = try(var.settings.enabled_log, {})
    content {
      category = enabled_log.value.category

    }
  }

  dynamic "enabled_metric" {
    for_each = try(var.settings.enabled_metric, {})
    content {
      category = enabled_metric.value.category

    }
  }

  log_analytics_workspace_id = (
    try(var.settings.log_analytics_workspace_ref, null) != null ?
    var.resources[
      try(var.settings.log_analytics_lz_key, var.client_config.landingzone_key)
    ].log_analytics_workspaces[var.settings.log_analytics_workspace_ref].id :
    null
  )

  storage_account_id = (
    try(var.settings.storage_account_ref, null) != null ?
    var.resources[
      try(var.settings.storage_account_lz_key, var.client_config.landingzone_key)
    ].storage_accounts[var.settings.storage_account_ref].id :
    null
  )
}
