resource "azurerm_private_dns_zone_virtual_network_link" "main" {
  for_each              = local.vnet_ids
  name                  = each.value.name_exact != "null" ? each.value.name_exact : "${each.value.name}-${azurerm_private_dns_zone.main.name}-link"
  private_dns_zone_name = azurerm_private_dns_zone.main.name
  resource_group_name   = azurerm_private_dns_zone.main.resource_group_name
  virtual_network_id    = each.value.id
  registration_enabled  = local.registration_enabled
}
