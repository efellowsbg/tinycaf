resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = local.network_interface_id
  network_security_group_id = local.network_security_group_id
}
