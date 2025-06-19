resource "azurerm_application_gateway" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  tags                = local.tags

  sku {
    name     = var.settings.sku.name
    tier     = var.settings.sku.tier
    capacity = var.settings.sku.capacity
  }

  dynamic "gateway_ip_configuration" {
    for_each = try(var.settings.gateway_ip_configuration, {})
    content {
      name      = gateway_ip_configuration.value.name
      subnet_id = var.resources[
        try(gateway_ip_configuration.value.lz_key, var.client_config.landingzone_key)
      ].virtual_networks[
        split("/", gateway_ip_configuration.value.subnet_ref)[0]
      ].subnets[
        split("/", gateway_ip_configuration.value.subnet_ref)[1]
      ].id
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = try(var.settings.frontend_ip_configuration, {})
    content {
      name                 = frontend_ip_configuration.value.name
      public_ip_address_id = var.resources[
        try(frontend_ip_configuration.value.lz_key, var.client_config.landingzone_key)
      ].public_ips[frontend_ip_configuration.value.public_ip].id
    }
  }

  dynamic "frontend_port" {
    for_each = try(var.settings.frontend_ports, {})
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "backend_address_pool" {
    for_each = try(var.settings.backend_address_pools, {})
    content {
      name         = backend_address_pool.value.name
      ip_addresses = try(backend_address_pool.value.ip_addresses, [])
    }
  }

  dynamic "backend_http_settings" {
    for_each = try(var.settings.backend_http_settings_list, {})
    content {
      name                  = backend_http_settings.value.name
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      cookie_based_affinity = try(backend_http_settings.value.cookie_based_affinity, "Disabled")
      request_timeout       = try(backend_http_settings.value.request_timeout, 20)
    }
  }

  dynamic "http_listener" {
    for_each = try(var.settings.http_listeners, {})
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      host_name                      = try(http_listener.value.host_name, null)
    }
  }

  dynamic "request_routing_rule" {
    for_each = try(var.settings.request_routing_rules, {})
    content {
      name                       = request_routing_rule.value.name
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
      priority                   = try(request_routing_rule.value.priority, 100)
    }
  }

  dynamic "timeouts" {
    for_each = can(var.settings.timeouts) ? [1] : []
    content {
      create = try(var.settings.timeouts.create, null)
      update = try(var.settings.timeouts.update, null)
      delete = try(var.settings.timeouts.delete, null)
    }
  }
}
