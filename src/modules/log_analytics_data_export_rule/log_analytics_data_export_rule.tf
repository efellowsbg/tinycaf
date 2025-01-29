resource "azurerm_log_analytics_data_export_rule" "main" {
  name                    = var.settings.name
  resource_group_name     = local.resource_group_name
  workspace_resource_id   = local.workspace_resource_id
  destination_resource_id = local.destination_resource_id
  table_names             = var.settings.table_names

  enabled = try(var.settings.enabled, false)

  dynamic "timeouts" {
    for_each = try(var.settings.timeouts[*], {})

    content {
      read   = try(timeouts.value.read, null)
      create = try(timeouts.value.create, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}
