resource "azurerm_dns_txt_record" "main" {
  for_each = try(var.settings.txt_records, {})

  name                = each.value.name
  zone_name           = azurerm_dns_zone.main.name
  resource_group_name = local.resource_group_name
  ttl                 = try(var.settings.txt_records[each.key].ttl, 300)
  tags                = try(var.settings.txt_records[each.key].tags, local.tags)

  dynamic "record" {
    for_each = try(var.settings.txt_records[each.key].records, {})
    content {
      value = record.value.value
    }
  }
}
