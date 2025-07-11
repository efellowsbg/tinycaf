resource "azurerm_log_analytics_workspace" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  sku                                     = try(var.settings.sku, "PerGB2018")
  retention_in_days                       = try(var.settings.retention_in_days, "30")
  internet_ingestion_enabled              = try(var.settings.internet_ingestion_enabled, true)
  allow_resource_only_permissions         = try(var.settings.allow_resource_only_permissions, true)
  internet_query_enabled                  = try(var.settings.internet_query_enabled, true)
  cmk_for_query_forced                    = try(var.settings.cmk_for_query_forced, null)
  data_collection_rule_id                 = try(var.settings.data_collection_rule_id, null)
  immediate_data_purge_on_30_days_enabled = try(var.settings.immediate_data_purge_on_30_days_enabled, null)
  daily_quota_gb                          = try(var.settings.daily_quota_gb, null)
  local_authentication_disabled           = try(var.settings.local_authentication_disabled, false)

  reservation_capacity_in_gb_per_day = try(
    var.settings.sku == "CapacityReservation" ?
    var.settings.reservation_capacity_in_gb_per_day : null,
    null
  )

  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []

    content {
      type         = try(var.settings.identity.type, null)
      identity_ids = try(local.identity_ids, null)
    }
  }

  dynamic "timeouts" {
    for_each = can(var.settings.timeouts) ? [1] : []

    content {
      read   = try(var.settings.timeouts.read, null)
      create = try(var.settings.timeouts.create, null)
      update = try(var.settings.timeouts.update, null)
      delete = try(var.settings.timeouts.delete, null)
    }
  }
}
