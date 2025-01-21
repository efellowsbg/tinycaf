output "id" {
  value = azurerm_linux_virtual_machine.main.id
}

output "private_ip_addresses" {
  value = azurerm_linux_virtual_machine.main.private_ip_addresses
}

output "public_ip_addresses" {
  value = azurerm_linux_virtual_machine.main.public_ip_addresses
}

output "nic_ids" {
  value = module.network_interface.id
}
