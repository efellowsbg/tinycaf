resource "azurerm_network_security_group" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags
}


resource "azurerm_network_security_rule" "main" {
  for_each = try(var.settings.security_rules, {})

  name                        = each.value.name
  priority                    = each.value.priority
  access                      = each.value.access
  direction                   = each.value.direction
  protocol                    = each.value.protocol
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.main.name

  description                                = try(each.value.description, null)
  source_port_range                          = try(each.value.source_port_range, null)
  source_port_ranges                         = try(each.value.source_port_ranges, null)
  destination_port_range                     = try(each.value.destination_port_range, null)
  destination_port_ranges                    = try(each.value.destination_port_ranges, null)
  source_address_prefix                      = try(each.value.source_address_prefix, null)
  source_address_prefixes                    = try(each.value.source_address_prefixes, null)
  source_application_security_group_ids      = try(each.value.source_application_security_group_ids, null)
  destination_address_prefix                 = try(each.value.destination_address_prefix, null)
  destination_address_prefixes               = try(each.value.destination_address_prefixes, null)
  destination_application_security_group_ids = try(each.value.destination_application_security_group_ids, null)
}