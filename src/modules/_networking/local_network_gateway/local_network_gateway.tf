resource "azurerm_local_network_gateway" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = var.settings.cidr

  gateway_address = try(var.settings.gateway_address, null)
  gateway_fqdn    = try(var.settings.gateway_fqdn, null)
}
