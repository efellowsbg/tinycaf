resource "azurerm_virtual_network_gateway" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  sku  = var.settings.sku
  type = try(var.settings.type, "Vpn")

  generation    = try(var.settings.generation, null)
  vpn_type      = try(var.settings.vpn_type, null)
  active_active = try(var.settings.active_active, null)
  enable_bgp    = try(var.settings.enable_bgp, null)

  dynamic "ip_configuration" {
    for_each = var.settings.ip_configurations

    content {
      name                          = ip_configuration.value.name
      private_ip_address_allocation = try(ip_configuration.value.private_ip_address_allocation, null)
      public_ip_address_id          = var.resources.public_ips[ip_configuration.value.public_ip_address_ref].id
      subnet_id                     = var.resources.virtual_networks[ip_configuration.value.vnet_ref].subnets[ip_configuration.value.subnet_ref].id
    }
  }
}
