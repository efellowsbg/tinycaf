resource "azurerm_network_interface" "main" {
  for_each                       = var.settings.network_interfaces
  name                           = each.value.name
  resource_group_name            = local.resource_group_name
  location                       = local.location
  accelerated_networking_enabled = try(each.value.accelerated_networking_enabled, false)
  ip_forwarding_enabled          = try(each.value.ip_forwarding_enabled, false)
  tags                           = local.tags

  dynamic "ip_configuration" {
    for_each = lookup(local.nic_ip_configs, each.key, {})
    content {
      name = ip_configuration.value.name

      subnet_id = try(
        var.resources[
          try(ip_configuration.value.subnet_lz_key, var.client_config.landingzone_key)
          ].virtual_networks[
          split("/", ip_configuration.value.subnet_ref)[0]
          ].subnets[
          split("/", ip_configuration.value.subnet_ref)[1]
        ].id,
        null
      )

      private_ip_address_allocation = try(ip_configuration.value.private_ip_address_allocation, "Dynamic")
      private_ip_address = try(
        ip_configuration.value.private_ip_address_allocation == "Static" ? ip_configuration.value.private_ip_address : null,
        null
      )

      public_ip_address_id = try(
        var.resources[
          try(ip_configuration.value.public_ip_lz_key, var.client_config.landingzone_key)
          ].public_ips[
          ip_configuration.value.public_ip_ref
        ].id,
        null
      )

      primary = try(ip_configuration.value.primary, false)
    }
  }
}


resource "azurerm_network_interface_security_group_association" "main" {
  for_each = {
    for key, val in var.settings.network_interfaces :
    key => val if try(val.network_security_group_ref, null) != null && try(val.network_security_group_ref, "") != ""
  }

  network_interface_id = azurerm_network_interface.main[each.key].id

  network_security_group_id = var.resources[
    try(each.value.network_security_group_lz_key, var.client_config.landingzone_key)
    ].network_security_groups[
    each.value.network_security_group_ref
  ].id
}
