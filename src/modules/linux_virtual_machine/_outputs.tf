output "id" {
  value = azurerm_linux_virtual_machine.main.id
}

output "private_ip_addresses" {
  value = azurerm_linux_virtual_machine.main.private_ip_addresses
}

output "public_ip_addresses" {
  value = azurerm_linux_virtual_machine.main.public_ip_addresses
}

output "nics" {
  value = {
    for _, nic_ref in try(var.settings.network_interface_ids) :
    nic_ref => azurerm_network_interface.main[nic_ref]
  }
}
