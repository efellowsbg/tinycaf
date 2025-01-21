resource "azurerm_network_interface" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location

  ip_configuration {
    name                          = var.settings.ip_configuration.name
    subnet_id                     = local.subnet_id[each.key]
    private_ip_address_allocation = try(var.settings.ip_configuration.private_ip_address_allocation, "Dynamic")
  }
}
