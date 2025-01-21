resource "azurerm_public_ip" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = try(var.settings.allocation_method, "Static")
  tags                = local.tags
  zones = try(var.settings.zones,null)
}
