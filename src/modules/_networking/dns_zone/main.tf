resource "azurerm_dns_zone" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  tags                = try(local.tags, null)

  dynamic "soa_record" {
    for_each = can(var.settings.identity) ? [1] : []
    content {
      email         = var.settings.soa_record.email
      host_name     = try(var.settings.soa_record.host_name, null)
      expire_time   = try(var.settings.soa_record.expire_time, null)
      minimum_ttl   = try(var.settings.soa_record.minimum_ttl, null)
      refresh_time  = try(var.settings.soa_record.refresh_time, null)
      retry_time    = try(var.settings.soa_record.retry_time, null)
      serial_number = try(var.settings.soa_record.serial_number, null)
      ttl           = try(var.settings.soa_record.ttl, null)
      tags          = local.tags
    }
  }
}
