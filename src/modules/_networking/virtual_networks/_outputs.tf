output "id" {
  value = azurerm_virtual_network.main.id
}

output "name" {
  value = azurerm_virtual_network.main.name
}

output "resource_group_name" {
  value = azurerm_virtual_network.main.resource_group_name
}

output "subnet_ids" {
  value = [for subnet in azurerm_subnet.main : subnet.id]
}

output "subnet_names" {
  value = [for subnet in azurerm_subnet.main : subnet.name]
}