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

  gateway_ip_configuration {
    name      = var.settings.gateway_ip_configuration.name
    subnet_id = var.settings.gateway_ip_configuration.subnet_id
  }

  frontend_ip_configuration {
    name                 = var.settings.frontend_ip_configuration.name
    public_ip_address_id = var.settings.frontend_ip_configuration.public_ip_address_id
  }

  dynamic "frontend_port" {
    for_each = try(var.settings.frontend_ports, [])
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "backend_address_pool" {
    for_each = try(var.settings.backend_address_pools, [])
    content {
      name         = backend_address_pool.value.name
      ip_addresses = try(backend_address_pool.value.ip_addresses, [])
    }
  }

  dynamic "backend_http_settings" {
    for_each = try(var.settings.backend_http_settings_list, [])
    content {
      name                  = backend_http_settings.value.name
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      cookie_based_affinity = try(backend_http_settings.value.cookie_based_affinity, "Disabled")
      request_timeout       = try(backend_http_settings.value.request_timeout, 20)
    }
  }

  dynamic "http_listener" {
    for_each = try(var.settings.http_listeners, [])
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      host_name                      = try(http_listener.value.host_name, null)
    }
  }

  dynamic "request_routing_rule" {
    for_each = try(var.settings.request_routing_rules, [])
    content {
      name                       = request_routing_rule.value.name
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
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
