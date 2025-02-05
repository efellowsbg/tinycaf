resource "azurerm_nat_gateway" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  sku_name                = try(var.settings.sku_name, null)
  idle_timeout_in_minutes = try(var.settings.idle_timeout_in_minutes, null)
  zones                   = try(var.settings.zones, null)

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
