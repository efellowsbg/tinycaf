resource "azurerm_private_endpoint" "example" {
  for_each = try(var.settings.private_endpoints, {})

  name                = each.value.name
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id           = local.subnet_id

  tags = local.tags

  private_service_connection {
    name                           = var.settings.private_service_connection.name
    private_connection_resource_id = azurerm_container_registry.main.id

    is_manual_connection              = try(var.settings.private_service_connection.is_manual_connection, false)
    private_connection_resource_alias = try(var.settings.private_service_connection.private_connection_resource_alias, null)
    subresource_names                 = try(var.settings.private_service_connection.subresource_names, null)
  }
}
