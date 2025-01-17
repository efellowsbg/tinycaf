resource "azurerm_private_endpoint" "main" {
  count               = try(var.settings.private_endpoint, null) != null ? 1 : 0
  name                = "pe-${azurerm_key_vault.main.name}"
  resource_group_name = azurerm_key_vault.main.resource_group_name
  location            = azurerm_key_vault.main.location
  subnet_id           = local.subnet_id

  tags = local.tags

  private_service_connection {
    name                           = "psc-${azurerm_key_vault.main.name}"
    private_connection_resource_id = azurerm_key_vault.main.id

    is_manual_connection              = try(var.settings.private_endpoint.private_service_connection.is_manual_connection, false)
    private_connection_resource_alias = try(var.settings.private_endpoint.private_service_connection.private_connection_resource_alias, null)
    subresource_names                 = try(var.settings.private_endpoint.private_service_connection.subresource_names, null)
  }
  private_dns_zone_group {
    name                 = try(var.settings.private_endpoint.dns_group_name, "default")
    private_dns_zone_ids = local.dns_zone_ids
  }
}
