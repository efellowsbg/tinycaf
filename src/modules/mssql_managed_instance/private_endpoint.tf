resource "azurerm_private_endpoint" "main" {
  count = try(var.settings.private_endpoint, null) == null ? 0 : 1

  name                = try(var.settings.private_endpoint.name, "pe-${var.settings.name}")
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id           = local.subnet_id
  tags                = try(var.settings.private_endpoint.tags, local.tags)

  private_service_connection {
    name                           = try(var.settings.private_endpoint.private_service_connection.name, "psc-${var.settings.name}")
    private_connection_resource_id = azurerm_container_registry.main.id
    is_manual_connection           = try(var.settings.private_endpoint.private_service_connection.is_manual_connection, false)
    subresource_names              = ["managedInstance"]
  }

  private_dns_zone_group {
    name                 = try(var.settings.private_endpoint.private_dns_zone_group_name, local.dns_zone_group_name)
    private_dns_zone_ids = local.private_dns_zone_ids
  }
}
