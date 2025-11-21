resource "azurerm_network_interface" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  tags                = local.tags

  dynamic "ip_configuration" {
    for_each = try(var.settings.ip_configuration, {})

    content {
      name                          = ip_configuration.value.name
      private_ip_address_allocation = try(ip_configuration.value.private_ip_address_allocation, "Dynamic")
      private_ip_address            = try(ip_configuration.value.private_ip_address, null)
      subnet_id = try(
        var.resources[
          try(ip_configuration.value.subnet_lz_key, var.client_config.landingzone_key)
          ].virtual_networks[
          split("/", ip_configuration.value.subnet_ref)[0]
          ].subnets[
          split("/", ip_configuration.value.subnet_ref)[1]
        ].id,
        ip_configuration.value.subnet_id, null
      )
      private_ip_address_version = try(ip_configuration.value.private_ip_address_version, "IPv4")
      public_ip_address_id = try(
        var.resources[
          try(ip_configuration.value.public_ip_lz_key, var.client_config.landingzone_key)
        ].public_ips[ip_configuration.value.public_ip_ref].id,
        ip_configuration.value.public_ip_id, null
      )
      gateway_load_balancer_frontend_ip_configuration_id = try(
        ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_id, null
      )
      primary = try(ip_configuration.value.primary, null)
    }
  }
}
