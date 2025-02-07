resource "azurerm_subnet" "main" {
  for_each = var.settings.subnets

  name                 = each.value.name
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = local.resource_group_name

  address_prefixes  = each.value.cidr
  service_endpoints = try(each.value.service_endpoints, null)
  # network_security_group_ref = try(each.value.network_security_group_ref, null)

  dynamic "delegation" {
    for_each = can(each.value.delegation) ? [1] : []

    content {
      name = local.delegations[each.value.delegation].name

      service_delegation {
        name    = local.delegations[each.value.delegation].service_delegation_name
        actions = local.delegations[each.value.delegation].service_delegation_actions
      }
    }
  }
}
