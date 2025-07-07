output "id" {
  value = azurerm_network_interface.main.id
}

output "private_ip_address" {
  value = try(azurerm_network_interface.main.private_ip_address, null)
}

output "private_ip_addresses" {
  value = try(azurerm_network_interface.main.private_ip_addresses, null)
}

output "virtual_machine_id" {
  value = try(azurerm_network_interface.main.virtual_machine_id, null)
}
