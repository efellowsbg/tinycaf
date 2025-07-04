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


resource "azurerm_subnet_route_table_association" "main" {
  for_each = var.settings.subnet_refs != null && length(var.settings.subnet_refs) > 0 ? {
    for idx, subnet_id in var.settings.subnet_refs : idx => subnet_id
  } : {}

  subnet_id      = var.resources[var.client_config.landingzone_key
  ].virtual_networks[
    split("/", each.value)[0]
  ].subnets[
    split("/", each.value)[1]
  ].id
  route_table_id = azurerm_route_table.main.id
}


