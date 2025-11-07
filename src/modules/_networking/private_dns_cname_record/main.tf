resource "azurerm_private_dns_cname_record" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  zone_name           = local.zone_name
  ttl                 = try(var.settings.ttl, 3600)
  record              = var.settings.record
  tags                = try(var.settings.tags, local.tags)

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
