resource "azurerm_network_interface" "main" {
  for_each = var.settings.network_interfaces

  name                = each.value.name
  resource_group_name = local.resource_group_name
  location            = local.location

  ip_configuration {
    name = each.value.ip_configuration.name
    subnet_id = var.resources.virtual_networks[
      split("/", each.value.ip_configuration.subnet_ref)[0]
      ].subnets[
      split("/", each.value.ip_configuration.subnet_ref)[1]
    ].id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
  }
}
