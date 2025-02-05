resource "azurerm_private_endpoint" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = "example-privateserviceconnection"
    private_connection_resource_id = azurerm_private_link_service.example.id
    is_manual_connection           = false
  }
}
