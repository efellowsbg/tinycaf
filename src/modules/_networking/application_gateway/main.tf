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
    ].waf_policies[var.settings.firewall_policy_ref].id,var.settings.firewall_policy_id,
    null
  )

  force_firewall_policy_association = try(
    var.settings.force_firewall_policy_association,
    true
  )

  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []
    content {
      type         = try(var.settings.identity.type, null)
      identity_ids = try(local.identity_ids, null)
    }
  }

  sku {
    name     = try(var.settings.sku.name, "WAF_v2")
    tier     = try(var.settings.sku.tier, "WAF_v2")
    capacity = try(var.settings.sku.capacity, 1)
  }

  dynamic "gateway_ip_configuration" {
    for_each = try(var.settings.gateway_ip_configurations, [])
    content {
      name = gateway_ip_configuration.value.name
      subnet_id = try(
        var.resources[
          try(gateway_ip_configuration.value.subnet_lz_key, var.client_config.landingzone_key)
        ].virtual_networks[
          split("/", gateway_ip_configuration.value.subnet_ref)[0]
        ].subnets[
          split("/", gateway_ip_configuration.value.subnet_ref)[1]
        ].id,
        gateway_ip_configuration.value.subnet_id,
        null
      )
    }
  }

  dynamic "frontend_port" {
    for_each = try(var.settings.frontend_ports, [])
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "http_listener" {
    for_each = try(var.settings.http_listeners, {})
    content {
      name                            = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      firewall_policy_id = try(
        var.resources[
          try(http_listener.value.firewall_policy_lz_key, var.client_config.landingzone_key)
        ].waf_policies[
          http_listener.value.firewall_policy_ref
        ].id,
        http_listener.value.firewall_policy_id,
        null
      )
      host_name                      = try(http_listener.value.host_name, null)
      ssl_certificate_name           = try(http_listener.value.ssl_certificate_name, null)
      host_names                     = try(http_listener.value.host_names, [])
      require_sni                    = try(http_listener.value.require_sni, true)
      ssl_profile_name = try(
        http_listener.value.ssl_profile_name,
        null
      )
    }
  }
  dynamic "ssl_certificate" {
    for_each = try(var.settings.ssl_certificates, {})
    content {
      name     = ssl_certificate.value.name
      data     = try(ssl_certificate.value.data,null)
      password = try(ssl_certificate.value.password, null)
      key_vault_secret_id = try(ssl_certificate.value.key_vault_secret_id, null)
    }
  }
  dynamic "frontend_ip_configuration" {
    for_each = try(var.settings.frontend_ip_configurations, [])
    content {
      name = frontend_ip_configuration.value.name
      subnet_id = try(
        var.resources[
          try(frontend_ip_configuration.value.subnet_lz_key, var.client_config.landingzone_key)
        ].virtual_networks[
          split("/", frontend_ip_configuration.value.subnet_ref)[0]
        ].subnets[
          split("/", frontend_ip_configuration.value.subnet_ref)[1]
        ].id,
        frontend_ip_configuration.value.subnet_id,
        null
      )
      public_ip_address_id = try(
        var.resources[
          try(frontend_ip_configuration.value.public_ip_lz_key, var.client_config.landingzone_key)
        ].public_ips[
          frontend_ip_configuration.value.public_ip_ref
        ].id,
        frontend_ip_configuration.value.public_ip_id,
        null
      )
      private_ip_address            = try(frontend_ip_configuration.value.private_ip_address, null)
      private_ip_address_allocation = try(frontend_ip_configuration.value.private_ip_address_allocation, null)
    }
  }

  dynamic "backend_address_pool" {
    for_each = try(var.settings.backend_address_pools, [])
    content {
      name         = backend_address_pool.value.name
      fqdns        = try(backend_address_pool.value.fqdns, [])
      ip_addresses = try(backend_address_pool.value.ip_addresses, [])
    }
  }

  dynamic "backend_http_settings" {
    for_each = try(var.settings.backend_http_settings, [])
    content {
      name                                = backend_http_settings.value.name
      cookie_based_affinity               = try(backend_http_settings.value.cookie_based_affinity, "Disabled")
      port                                = backend_http_settings.value.port
      protocol                            = backend_http_settings.value.protocol
      affinity_cookie_name                = try(backend_http_settings.value.affinity_cookie_name, null)
      pick_host_name_from_backend_address = try(backend_http_settings.value.pick_host_name_from_backend_address, false)
      probe_name                          = try(backend_http_settings.value.probe_name, null)
      request_timeout                     = try(backend_http_settings.value.request_timeout, 350)
      path = try(backend_http_settings.value.path, null)
    }
  }
  dynamic "probe" {
    for_each = try(var.settings.probes, {})
    content {
      name                = probe.value.name
      host = try(probe.value.host, null)
      protocol            = probe.value.protocol
      path                = probe.value.path
      interval            = try(probe.value.interval, 30)
      timeout             = try(probe.value.timeout, 30)
      minimum_servers = try(probe.value.minimum_servers, 0)
      unhealthy_threshold = try(probe.value.unhealthy_threshold, 3)
      dynamic "match" {
        for_each = try(probe.value.match, {})
        content {
          body = try(match.value.body, null)
          status_code = try(match.value.status_code, ["200-399"])
        }
      }
    }
  }

  dynamic "request_routing_rule" {
    for_each = try(var.settings.request_routing_rules, {})
    content {
      name                       = request_routing_rule.value.name
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = try(request_routing_rule.value.backend_address_pool_name, null)
      backend_http_settings_name = try(request_routing_rule.value.backend_http_settings_name, null)
      redirect_configuration_name = try(request_routing_rule.value.redirect_configuration_name, null)
      rewrite_rule_set_name = try(request_routing_rule.value.rewrite_rule_set_name, null)
      url_path_map_name = try(request_routing_rule.value.url_path_map_name, null)
      priority = try(request_routing_rule.value.priority, null)
    }
  }
}
