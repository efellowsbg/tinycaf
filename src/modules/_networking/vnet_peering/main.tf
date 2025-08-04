resource "azurerm_virtual_network_peering" "left_to_right" {
  count = local.peer_left_to_right ? 1 : 0

  name                      = try(var.settings.name_left_to_right, "peering-${local.vnet_left.name}-to-${local.vnet_right.name}")
  resource_group_name       = local.vnet_left.resource_group_name
  virtual_network_name      = local.vnet_left.name
  remote_virtual_network_id = local.vnet_right.id
}

resource "azurerm_virtual_network_peering" "right_to_left" {
  count = local.peer_right_to_left ? 1 : 0

  name                      = try(var.settings.name_right_to_left, "peering-${local.vnet_right.name}-to-${local.vnet_left.name}")
  resource_group_name       = local.vnet_right.resource_group_name
  virtual_network_name      = local.vnet_right.name
  remote_virtual_network_id = local.vnet_left.id
}

resource "azurerm_virtual_network_peering" "target" {
  count = local.target ? 1 : 0

  name                         = try(var.settings.name_target, "peering-${local.vnet_right.name}")
  resource_group_name          = local.vnet_right.resource_group_name
  virtual_network_name         = local.vnet_right.name
  remote_virtual_network_id    = try(var.settings.remote_vnet_id, local.vnet_left.id)
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}

resource "azurerm_virtual_network_peering" "custom" {
  count = local.custom ? 1 : 0

  name                         = try(var.settings.custom_name, "peering-${local.vnet_right.name}")
  resource_group_name          = local.vnet_right.resource_group_name
  virtual_network_name         = local.vnet_right.name
  remote_virtual_network_id    = try(var.settings.remote_vnet_id, local.vnet_left.id)
  allow_virtual_network_access = try(var.settings.allow_virtual_network_access, false)
  allow_forwarded_traffic      = try(var.settings.allow_forwarded_traffic, false)
  use_remote_gateways          = try(var.settings.use_remote_gateways, false)
  allow_gateway_transit        = try(var.settings.allow_gateway_transit, false)
}

resource "azurerm_virtual_network_peering" "source" {
  count = local.source ? 1 : 0

  name                         = "peering-${local.vnet_left.name}"
  resource_group_name          = local.vnet_left.resource_group_name
  virtual_network_name         = local.vnet_left.name
  remote_virtual_network_id    = try(var.settings.remote_vnet_id, local.vnet_right.id)
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}
