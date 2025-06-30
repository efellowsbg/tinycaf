resource "azurerm_application_gateway" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  enable_http2        = try(var.settings.enable_http2, true)
  tags                = local.tags
  fips_enabled        = try(var.settings.fips_enabled, false)
  firewall_policy_id = try(
    var.resources[
      try(var.settings.firewall_policy_lz_key, var.client_config.landingzone_key)
    ].waf_policies[var.settings.firewall_policy_ref].id,
    null
  )
  force_firewall_policy_association = try(
    var.settings.force_firewall_policy_association,
    false
  )
  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []

    content {
      type         = try(var.settings.identity.type, null)
      identity_ids = try(local.identity_ids, null)
    }
  }
  sku {
    name     = try(var.settings.sku.name, "Standard_v2")
    tier     = try(var.settings.sku.tier, "Standard_v2")
    capacity = try(var.settings.sku.capacity, 2)
  }
  dynamic "gateway_ip_configuration" {
    for_each = var.settings.gateway_ip_configuration
    content {
      name = each.value.name
      subnet_id = try(
        var.resources[
          try(each.value.subnet_lz_key, var.client_config.landingzone_key)
          ].virtual_networks[
          split("/", each.value.subnet_ref)[0]
          ].subnets[
          split("/", each.value.subnet_ref)[1]
        ].id,
        each.value.subnet_id,
        null
      )
    }
  }
  dynamic "frontend_port" {
    for_each = var.settings.frontend_ports
    content {
      name = each.value.name
      port = each.value.port
    }
  }
  dynamic "http_listener" {
    for_each = var.settings.http_listeners
    content {
      name                           = each.value.name
      frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
      frontend_port_name             = each.value.frontend_port_name
      protocol                       = each.value.protocol
      host_name                      = try(each.value.host_name, null)
      ssl_certificate_name           = try(each.value.ssl_certificate_name, null)
      host_names                     = try(each.value.host_names, [])
      require_sni                    = try(each.value.require_sni, true)
      ssl_certificate_id = try(
        var.resources[
          try(each.value.ssl_certificate_lz_key, var.client_config.landingzone_key)
          ].application_gateways[
          each.value.ssl_certificate_ref
        ].ssl_certificates[each.value.ssl_certificate_name].id,
        each.value.ssl_certificate_id,
        null
      )
    }
  }
  dynamic "frontend_ip_configuration" {
    for_each = var.settings.frontend_ip_configurations
    content {
      name = each.value.name
      subnet_id = try(
        var.resources[
          try(each.value.subnet_lz_key, var.client_config.landingzone_key)
          ].virtual_networks[
          split("/", each.value.subnet_ref)[0]
          ].subnets[
          split("/", each.value.subnet_ref)[1]
        ].id,
        each.value.subnet_id,
        null
      )
      public_ip_address_id = try(
        var.resources[
          try(each.value.public_ip_lz_key, var.client_config.landingzone_key)
          ].public_ips[
        each.value.public_ip_ref].id, each.value.public_ip_id,
        null
      )
      private_ip_address            = try(each.value.private_ip_address, null)
      private_ip_address_allocation = try(each.value.private_ip_address_allocation, null)
    }
  }
  dynamic "backend_address_pool" {
    for_each = var.settings.backend_address_pools
    content {
      name         = each.value.name
      fqdns        = try(each.value.fqdns, [])
      ip_addresses = try(each.value.ip_addresses, [])
    }
  }
  dynamic "backend_http_settings" {
    for_each = var.settings.backend_http_settings
    content {
      name                                = each.value.name
      cookie_based_affinity               = try(each.value.cookie_based_affinity, "Disabled")
      port                                = each.value.port
      protocol                            = each.value.protocol
      affinity_cookie_name                = try(each.value.affinity_cookie_name, null)
      pick_host_name_from_backend_address = try(each.value.pick_host_name_from_backend_address, false)
      probe_name                          = try(each.value.probe_name, null)
      request_timeout                     = try(each.value.request_timeout, 350)
    }
  }
  dynamic "request_routing_rule" {
    for_each = var.settings.request_routing_rules
    content {
      name                       = each.value.name
      rule_type                  = each.value.rule_type
      http_listener_name         = each.value.http_listener_name
      backend_address_pool_name  = try(each.value.backend_address_pool_name, null)
      backend_http_settings_name = try(each.value.backend_http_settings_name, null)
    }
  }
}
