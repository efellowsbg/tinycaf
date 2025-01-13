resource "azurerm_virtual_network" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = var.settings.cidr
  tags                = try(local.tags, null)
}
