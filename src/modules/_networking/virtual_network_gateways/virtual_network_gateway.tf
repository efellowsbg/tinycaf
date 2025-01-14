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
    for_each = try(var.settings.ip_configuration, {})
    content {
      name                          = ip_configuration.value.name
      public_ip_address_id          = can(ip_configuration.value.public_ip_address_id) || can(ip_configuration.value.public_ip_address_key) == false ? try(ip_configuration.value.public_ip_address_id, null) : var.resources.public_ips[ip_configuration.value.public_ip_address_ref].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      subnet_id = can(ip_configuration.value.subnet_id) ? ip_configuration.value.subnet_id : azurerm_subnet.main["${ip_configuration.value.vnet_ref}.${ip_configuration.value.subnet_ref}"].id
    }
  }
}
