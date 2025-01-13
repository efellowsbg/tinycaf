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
      address_prefixes = subnet.address_prefixes
      security_group   = try(subnet.value.nsg_ref, null) == null ? null : var.resources.network_security_group[subnet.value.nsg_ref].id
    }
  }
}
