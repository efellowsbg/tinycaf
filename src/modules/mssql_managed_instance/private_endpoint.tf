resource "azurerm_private_endpoint" "main" {
  count = try(var.settings.private_endpoint, null) == null ? 0 : 1

  name                = try(var.settings.private_endpoint.name, "pe-${var.settings.name}")
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id = var.resources[
    try(var.settings.private_endpoint.subnet_lz_key, var.client_config.landingzone_key)
    ].virtual_networks[
    split("/", var.settings.private_endpoint.subnet_ref)[0]
    ].subnets[
    split("/", var.settings.private_endpoint.subnet_ref)[1]
  ].id
  tags = try(var.settings.private_endpoint.tags, local.tags)

  private_service_connection {
    name                           = try(var.settings.private_endpoint.private_service_connection.name, "psc-${var.settings.name}")
    private_connection_resource_id = azurerm_mssql_managed_instance.main.id
    is_manual_connection           = try(var.settings.private_endpoint.private_service_connection.is_manual_connection, false)
    subresource_names              = ["managedInstance"]
  }

  dynamic "private_dns_zone_group" {
    for_each = can(var.settings.private_endpoint.private_dns_zone_group) ? [1] : []

    content {
      name                 = try(var.settings.private_endpoint.private_dns_zone_group_name, local.dns_zone_group_name)
      private_dns_zone_ids = local.private_dns_zone_ids
    }
  }
}
