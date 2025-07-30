resource "azurerm_virtual_network_gateway_nat_rule" "main" {
  for_each                   = try(var.settings.vng_nat_rules, {})
  name                       = each.value.name
  resource_group_name        = local.resource_group_name
  virtual_network_gateway_id = azurerm_virtual_network_gateway.main.id
  mode                       = try(each.value.mode, "EgressSnat")
  type                       = try(each.value.type, "Static")
  ip_configuration_id        = try(each.value.ip_configuration_id, "")

  dynamic "external_mapping" {
    for_each = each.value.external_mapping

    content {
      address_space = external_mapping.value.address_space
      port_range    = try(external_mapping.value.port_range, null)
    }
  }

  dynamic "internal_mapping" {
    for_each = each.value.internal_mapping

    content {
      address_space = internal_mapping.value.address_space
      port_range    = try(internal_mapping.value.port_range, null)
    }
  }
}
