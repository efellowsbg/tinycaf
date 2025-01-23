resource "azurerm_private_endpoint" "main" {
  name                = var.settings.private_endpoint.name
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id           = local.subnet_id

  tags = local.tags

  private_service_connection {
    name                              = var.settings.private_endpoint.private_service_connection.name
    private_connection_resource_id    = azurerm_container_registry.main.id
    is_manual_connection              = try(var.settings.private_endpoint.private_service_connection.is_manual_connection, true)
    private_connection_resource_alias = try(var.settings.private_endpoint.private_service_connection.private_connection_resource_alias, null)
    subresource_names                 = try(var.settings.private_endpoint.private_service_connection.subresource_names, null)
  }

  private_dns_zone_group {
    name                 = local.dns_zone_group_name
    private_dns_zone_ids = local.private_dns_zone_ids
  }
}
