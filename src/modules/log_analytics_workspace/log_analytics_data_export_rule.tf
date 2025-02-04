resource "azurerm_log_analytics_data_export_rule" "main" {
  for_each = try(var.settings.rules, {})

  name                    = each.value.name
  resource_group_name     = local.resource_group_name
  workspace_resource_id   = azurerm_log_analytics_workspace.main.id
  destination_resource_id = var.resources.storage_accounts[each.value.storage_account_ref].id
  table_names             = each.value.table_names

  enabled = try(each.value.enabled, false)

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
