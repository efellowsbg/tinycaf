resource "azurerm_application_insights_workbook" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  display_name        = var.settings.display_name
  data_json           = var.settings.data_json
  tags                = local.tags

  source_id            = try(var.settings.source_id, null)
  category             = try(var.settings.category, null)
  description          = try(var.settings.description, null)
  storage_container_id = try(var.settings.storage_container_id, null)


  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []

    content {
      type         = try(var.settings.identity.type, null)
      identity_ids = try(local.identity_ids, null)
    }
  }
}
