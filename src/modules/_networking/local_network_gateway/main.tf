resource "azurerm_local_network_gateway" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = try(var.settings.cidr, null)

  gateway_address = try(var.settings.gateway_address, null)
  gateway_fqdn    = try(var.settings.gateway_fqdn, null)

  dynamic "bgp_settings" {
    for_each = can(var.settings.bgp_settings) ? [1] : []

    content {
      asn                 = var.settings.bgp_settings.asn
      bgp_peering_address = var.settings.bgp_settings.bgp_peering_address
      peer_weight = try(var.settings.bgp_settings.peer_weight, null)
    }
  }
}
