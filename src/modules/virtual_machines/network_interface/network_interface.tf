resource "azurerm_network_interface" "main" {
  name                = var.settings.network_interfaces.name
  resource_group_name = local.resource_group_name
  location            = local.location

  ip_configuration {
    name                          = var.settings.network_interfaces.ip_configuration.name
    subnet_id                     = local.subnet_id
    private_ip_address_allocation = try(var.settings.ip_configuration.private_ip_address_allocation, "Dynamic")
  }
}
