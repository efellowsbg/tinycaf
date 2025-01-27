resource "azurerm_private_endpoint" "main" {
  name                = "pe-${var.settings.name}"
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id           = local.subnet_id

  tags = local.tags

  private_service_connection {
    name                           = try(var.settings.private_endpoint.private_service_connection.name, "psc-${var.settings.name}")
    private_connection_resource_id = azurerm_container_registry.main.id
    is_manual_connection           = try(var.settings.private_endpoint.private_service_connection.is_manual_connection, false)
    subresource_names              = var.settings.private_endpoint.private_service_connection.subresource_names
  }

  private_dns_zone_group {
    name                 = local.dns_zone_group_name
    private_dns_zone_ids = local.private_dns_zone_ids
  }
}
