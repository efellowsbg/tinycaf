resource "azurerm_logic_app_workflow" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []
    content {
      type         = var.settings.identity.type
      identity_ids = try(local.identity_ids, null)
    }
  }
}