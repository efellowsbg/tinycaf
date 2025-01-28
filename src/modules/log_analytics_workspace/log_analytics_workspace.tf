resource "azurerm_log_analytics_workspace" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  retention_in_days                       = try(var.settings.retention_in_days, null)
  sku                                     = try(var.settings.sku, "PerGB2018")
  allow_resource_only_permissions         = try(var.settings.allow_resource_only_permissions, true)
  local_authentication_disabled           = try(var.settings.local_authentication_disabled, false)
  cmk_for_query_forced                    = try(var.settings.cmk_for_query_forced, null)
  internet_ingestion_enabled              = try(var.settings.internet_ingestion_enabled, true)
  internet_query_enabled                  = try(var.settings.internet_query_enabled, true)
  data_collection_rule_id                 = try(var.settings.data_collection_rule_id, null)
  immediate_data_purge_on_30_days_enabled = try(var.settings.immediate_data_purge_on_30_days_enabled, null)

  daily_quota_gb = try(
    var.settings.daily_quota_gb,
    var.settings.sku == "Free" ? "0.5" : "-1"
  )

  reservation_capacity_in_gb_per_day = try(
    var.settings.sku == "CapacityReservation" ?
    var.settings.reservation_capacity_in_gb_per_day : null,
    null
  )

  dynamic "identity" {
    for_each = try(var.settings.identities, null)

    content {
      type         = try(identity.type, null)
      identity_ids = try(identity.identity_ids, null)
    }
  }

  dynamic "timeouts" {
    for_each = try(var.settings.timeouts, null)

    content {
      read   = try(timeouts.read, "5m")
      create = try(timeouts.create, "30m")
      update = try(timeouts.update, "30m")
      delete = try(timeouts.delete, "30m")
    }
  }
}
