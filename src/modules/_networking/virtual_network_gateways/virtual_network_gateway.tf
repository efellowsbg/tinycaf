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
      name                          = each.value.name
      public_ip_address_id          = local.public_ip_address_id
      private_ip_address_allocation = try(each.value.private_ip_address_allocation, "Dynamic")
      subnet_id                     = local.subnet_id
    }
  }
}
