resource "azurerm_virtual_network_peering" "main" {
  for_each = {
    for key, peering in local.peerings : key => peering
    if (var.direction == "both" || var.direction == peering.direction) &&
       peering.source_vnet != null && peering.target_vnet != null
  }

  name                      = "${each.value.source_vnet.name}-to-${each.value.target_vnet.name}"
  resource_group_name       = each.value.source_vnet.resource_group_name
  virtual_network_name      = each.value.source_vnet.name
  remote_virtual_network_id = each.value.target_vnet.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}