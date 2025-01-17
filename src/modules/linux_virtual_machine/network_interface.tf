resource "azurerm_network_interface" "main" {
  for_each = var.settings.network_interfaces

  name                = each.value.name
  resource_group_name = local.resource_group_name
  location            = local.location

  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id                     = local.subnet_id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
  }
}
