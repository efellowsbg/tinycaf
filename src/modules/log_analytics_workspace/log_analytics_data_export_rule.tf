resource "azurerm_log_analytics_data_export_rule" "main" {
  for_each = try(var.settings.rules, {})

  name                    = each.value.name
  resource_group_name     = local.resource_group_name
  workspace_resource_id   = azurerm_log_analytics_workspace.main.id
  destination_resource_id = module.storage_accounts[each.value.storage_account_ref].id
  table_names             = each.value.table_names

  enabled = try(each.value.enabled, false)

  depends_on = [azurerm_log_analytics_workspace.main]

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
