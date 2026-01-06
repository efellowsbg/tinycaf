resource "azurerm_virtual_network_gateway" "main" {
  name                                  = var.settings.name
  resource_group_name                   = local.resource_group_name
  location                              = local.location
  tags                                  = local.tags
  sku                                   = try(var.settings.sku, "VpnGw1")
  type                                  = try(var.settings.type, "Vpn")
  active_active                         = try(var.settings.active_active, false)
  generation                            = try(var.settings.generation, null)
  vpn_type                              = try(var.settings.vpn_type, null)
  enable_bgp                            = try(var.settings.enable_bgp, null)
  bgp_route_translation_for_nat_enabled = try(var.settings.bgp_route_translation_for_nat_enabled, null)
  edge_zone                             = try(var.settings.edge_zone, null)
  private_ip_address_enabled            = try(var.settings.private_ip_address_enabled, null)
  dns_forwarding_enabled                = try(var.settings.dns_forwarding_enabled, null)
  ip_sec_replay_protection_enabled      = try(var.settings.ip_sec_replay_protection_enabled, null)
  remote_vnet_traffic_enabled           = try(var.settings.remote_vnet_traffic_enabled, null)
  virtual_wan_traffic_enabled           = try(var.settings.virtual_wan_traffic_enabled, null)

  dynamic "ip_configuration" {
    for_each = var.settings.ip_configurations

    content {
      name                          = ip_configuration.value.name
      private_ip_address_allocation = try(ip_configuration.value.private_ip_address_allocation, null)

      public_ip_address_id = var.resources[
        try(ip_configuration.value.lz_key, ip_configuration.value.pip_lz_key, var.client_config.landingzone_key)
      ].public_ips[ip_configuration.value.public_ip_address_ref].id

      subnet_id = var.resources[
        try(ip_configuration.value.lz_key, ip_configuration.value.snet_lz_key, var.client_config.landingzone_key)
        ].virtual_networks[
        split("/", ip_configuration.value.subnet_ref)[0]
        ].subnets[
        split("/", ip_configuration.value.subnet_ref)[1]
      ].id
    }
  }

  dynamic "vpn_client_configuration" {
    for_each = can(var.settings.vpn_client_configuration) ? [1] : []

    content {
      address_space        = var.settings.vpn_client_configuration.address_space
      vpn_client_protocols = try(var.settings.vpn_client_configuration.vpn_client_protocols, ["OpenVPN"])
      vpn_auth_types       = try(var.settings.vpn_client_configuration.vpn_auth_types, ["AAD"])
      aad_tenant           = "https://login.microsoftonline.com/${var.global_settings.tenant_id}"
      aad_audience         = try(var.settings.vpn_client_configuration.aad_audience, "c632b3df-fb67-4d84-bdcf-b95ad541b5c8")
      aad_issuer           = "https://sts.windows.net/${var.global_settings.tenant_id}/"
    }
  }

  dynamic "bgp_settings" {
    for_each = can(var.settings.bgp_settings) ? [1] : []

    content {
      asn         = try(var.settings.bgp_settings.asn, null)
      peer_weight = try(var.settings.bgp_settings.peer_weight, null)

      dynamic "peering_addresses" {
        for_each = try(var.settings.bgp_settings.peering_addresses, [])

        content {
          ip_configuration_name = try(peering_addresses.value.ip_configuration_name, null)
          apipa_addresses       = try(peering_addresses.value.apipa_addresses, null)
        }
      }
    }
  }
}
