resource "azurerm_log_analytics_data_export_rule" "main" {
  name                    = var.settings.name
  resource_group_name     = local.resource_group_name
  workspace_resource_id   = local.workspace_resource_id
  destination_resource_id = local.destination_resource_id
  table_names             = var.settings.table_names

  enabled = try(var.settings.enabled, false)

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
