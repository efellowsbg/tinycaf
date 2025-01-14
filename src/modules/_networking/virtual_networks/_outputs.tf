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
  value = azurerm_subnet.main[each.key].id
}

output "subnet_name" {
  value = azurerm_subnet.main[each.key].name
}