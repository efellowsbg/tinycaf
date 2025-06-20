resource "azurerm_monitor_diagnostic_setting" "main" {
  for_each = var.diagnostic_setting

  name               = each.value.name
  target_resource_id = var.resources[
    try(each.value.resource_lz_key, var.client_config.landingzone_key)
  ][each.value.resource_type][each.value.resource_ref].id

  dynamic "log" {
    for_each = try(each.value.logs, {})
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
    for_each = try(each.value.metrics, {})
    content {
      category = metric.value.category
      enabled  = metric.value.enabled


    }
  }

  log_analytics_workspace_id = (
    try(each.value.log_analytics_workspace_ref, null) != null ?
    var.resources[
      try(each.value.log_analytics_lz_key, var.client_config.landingzone_key)
    ].log_analytics[each.value.log_analytics_workspace_ref].id :
    null
  )

  storage_account_id = (
    try(each.value.storage_account_ref, null) != null ?
    var.resources[
      try(each.value.storage_account_lz_key, var.client_config.landingzone_key)
    ].storage_accounts[each.value.storage_account_ref].id :
    null
  )
}
