resource "azurerm_role_definition" "main" {
  name  = var.settings.name
  scope = "/subscriptions/${var.global_settings.subscription_id}"

  assignable_scopes  = try(var.settings.assignable_scopes, null)
  role_definition_id = try(var.settings.role_definition_id, null)
  description        = try(var.settings.description, "This is a custom role created via Terraform")

  dynamic "permissions" {
    for_each = can(var.settings.permissions) ? [1] : []

    content {
      actions          = try(var.settings.permissions.actions, null)
      not_actions      = try(var.settings.permissions.not_actions, null)
      data_actions     = try(var.settings.permissions.data_actions, null)
      not_data_actions = try(var.settings.permissions.not_data_actions, null)
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
