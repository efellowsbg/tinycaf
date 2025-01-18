resource "azurerm_private_endpoint" "main" {
  for_each = {
    for key, value in var.resources.keyvaults :
    key => value
    if try(var.settings.private_endpoint, null) != null
  }
  name                = "pe-${each.value.name}.name}"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  subnet_id           = local.subnet_id

  tags = local.tags

  private_service_connection {
    name                           = "psc-${each.value.name}"
    private_connection_resource_id = each.value.id

    is_manual_connection              = try(var.settings.private_endpoint.private_service_connection.is_manual_connection, false)
    private_connection_resource_alias = try(var.settings.private_endpoint.private_service_connection.private_connection_resource_alias, null)
    subresource_names                 = try(var.settings.private_endpoint.private_service_connection.subresource_names, null)
  }
  private_dns_zone_group {
    name                 = try(var.settings.private_endpoint.dns_group_name, "default")
    private_dns_zone_ids = local.dns_zone_ids
  }
}
