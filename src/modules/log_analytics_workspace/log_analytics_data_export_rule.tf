resource "azurerm_log_analytics_data_export_rule" "main" {
  for_each = try(var.settings.log_analytics_data_export_rules, {})

  name                    = each.value.name
  resource_group_name     = local.resource_group_name
  workspace_resource_id   = azurerm_log_analytics_workspace.main.id
  destination_resource_id = local.destination_resource_id
  table_names             = each.value.table_names

  enabled = try(each.value.enabled, false)

  dynamic "timeouts" {
    for_each = try(each.value.timeouts[*], {})

    content {
      read   = try(timeouts.value.read, null)
      create = try(timeouts.value.create, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}
