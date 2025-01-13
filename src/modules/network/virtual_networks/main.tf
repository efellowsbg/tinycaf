resource "azurerm_virtual_network" "vnet" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = var.settings.address_space
  tags                = try(local.tags, null)

  dns_servers = try(var.settings.dns_servers, null)
  dynamic "subnet" {
    for_each = var.settings.subnets
    content {
      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
      security_group   = try(subnet.value.nsg_ref, null) == null ? null : var.resources.network_security_group[subnet.value.nsg_ref].id
      service_endpoints = try(subnet.value.service_endpoints, null)
      dynamic "delegation" {
        for_each = try([subnet.value.delegation], [])  # Include only if delegation is defined
        content {
          name = delegation.value.name
          service_delegation {
            name    = delegation.value.service_delegation.name
            actions = try(delegation.value.service_delegation.actions, null)
          }
        }
    }
  }
}
