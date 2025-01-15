resource "azurerm_virtual_network_gateway" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  generation          = var.settings.generation
  type                = try(var.settings.type, "Vpn")
  vpn_type            = try(var.settings.vpn_type, "RouteBased")
  active_active       = try(var.settings.active_active, false)
  enable_bgp          = try(var.settings.enable_bgp, false)
  sku                 = try(var.settings.sku, "VpnGw1")

  dynamic "ip_configuration" {
    for_each = try(var.settings.ip_configurations, {})
    content {
      name                          = ip_configuration.value.name
      private_ip_address_allocation = try(ip_configuration.value.private_ip_address_allocation, null)
      public_ip_address_id = (
        can(ip_configuration.value.public_ip_address_id) || !can(ip_configuration.value.public_ip_address_key)
      ) ? try(ip_configuration.value.public_ip_address_id, null) : var.resources.public_ips[ip_configuration.value.public_ip_address_ref].id

      subnet_id = can(ip_configuration.value.subnet_id) ? ip_configuration.value.subnet_id : var.resources.virtual_networks[ip_configuration.value.vnet_ref].subnets[ip_configuration.value.subnet_ref].id
    }
  }
}
