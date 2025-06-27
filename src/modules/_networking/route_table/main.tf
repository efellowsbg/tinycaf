resource "azurerm_route_table" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location

  tags = local.tags

  dynamic "route" {
    for_each = var.settings.routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = try(route.value.next_hop_in_ip_address, null)
    }
  }
}
