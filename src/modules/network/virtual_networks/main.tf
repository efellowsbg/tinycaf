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
      name             = var.settings.subnet.value.name
      address_prefixes = var.settings.subnet.address_prefixes
      security_group   = try(var.settings.subnet.nsg_ref, null) == null ? null : var.resources.network_security_group[var.settings.subnet.nsg_ref].id
    }
  }
}
