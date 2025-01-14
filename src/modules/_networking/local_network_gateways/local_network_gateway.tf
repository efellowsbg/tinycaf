resource "azurerm_local_network_gateway" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  gateway_address     = var.settings.gateway_address
  address_space       = var.settings.address_space
}
