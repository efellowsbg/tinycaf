resource "azurerm_private_endpoint" "main" {
  name                = try(var.settings.private_endpoint.name,"pe-${var.settings.name}")
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id           = local.subnet_id

  tags = local.tags

  private_service_connection {
    name                           = try(var.settings.private_endpoint.private_service_connection.name,"psc-${var.settings.name}")
    private_connection_resource_id = var.keyvault_id

    is_manual_connection              = try(var.settings.private_endpoint.private_service_connection.is_manual_connection, false)
    private_connection_resource_alias = try(var.settings.private_endpoint.private_service_connection.private_connection_resource_alias, null)
    subresource_names                 = try(var.settings.private_endpoint.private_service_connection.subresource_names, null)
  }
  private_dns_zone_group {
    name                 = try(var.settings.private_endpoint.dns_group_name, "default")
    private_dns_zone_ids = local.dns_zone_ids
  }
}
