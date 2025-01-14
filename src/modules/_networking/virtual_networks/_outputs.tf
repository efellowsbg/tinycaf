output "id" {
  value = azurerm_virtual_network.main.id
}

output "name" {
  value = azurerm_virtual_network.main.name
}

output "resource_group_name" {
  value = azurerm_virtual_network.main.resource_group_name
}

output "subnet_id" {
  value = { for key, subnet in azurerm_subnet.main : key => subnet.id }
}

output "subnet_name" {
  value = { for key, subnet in azurerm_subnet.main : key => subnet.name }
}