resource "azurerm_private_endpoint" "main" {
  name                          = var.settings.name
  resource_group_name           = local.resource_group_name
  location                      = local.location
  tags                          = local.tags
  subnet_id                     = try(local.subnet_id, var.settings.subnet_ref)
  custom_network_interface_name = try(var.settings.custom_network_interface_name, null)

  private_service_connection {
    name                           = var.settings.private_service_connection.name
    private_connection_resource_id = local.private_connection_resource_id
    is_manual_connection           = try(var.settings.private_service_connection.is_manual_connection, false)

    subresource_names = try(var.settings.private_service_connection.subresource_names, null)
    request_message   = try(var.settings.private_service_connection.request_message, null)
  }

  dynamic "private_dns_zone_group" {
    for_each = can(var.settings.private_dns_zone_group) ? [1] : []

    content {
      name                 = var.settings.private_dns_zone_group.name
      private_dns_zone_ids = try(local.private_dns_zone_ids, var.settings.private_dns_zone_group.private_dns_zone_ids)
    }
  }

  dynamic "ip_configuration" {
    for_each = try(var.settings.ip_configuration, {})

    content {
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name   = try(ip_configuration.value.subresource_name, null)
      member_name        = try(ip_configuration.value.member_name, null)
    }
  }
}
