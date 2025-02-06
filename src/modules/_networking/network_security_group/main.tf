resource "azurerm_network_security_group" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  dynamic "security_rule" {
    for_each = try(var.settings.security_rules, {})

    content {
      name      = security_rule.value.name
      priority  = security_rule.value.priority
      access    = security_rule.value.access
      direction = security_rule.value.direction
      protocol  = security_rule.value.protocol

      description                                = try(security_rule.value.description, null)
      source_port_range                          = try(security_rule.value.source_port_range, null)
      source_port_ranges                         = try(security_rule.value.source_port_ranges, null)
      destination_port_range                     = try(security_rule.value.destination_port_range, null)
      destination_port_ranges                    = try(security_rule.value.destination_port_ranges, null)
      source_address_prefix                      = try(security_rule.value.source_address_prefix, null)
      source_address_prefixes                    = try(security_rule.value.source_address_prefixes, null)
      source_application_security_group_ids      = try(security_rule.value.source_application_security_group_ids, null)
      destination_address_prefix                 = try(security_rule.value.destination_address_prefix, null)
      destination_address_prefixes               = try(security_rule.value.destination_address_prefixes, null)
      destination_application_security_group_ids = try(security_rule.value.destination_application_security_group_ids, null)
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
