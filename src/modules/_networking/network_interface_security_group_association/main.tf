resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = local.network_interface_id
  network_security_group_id = local.network_security_group_id
}
