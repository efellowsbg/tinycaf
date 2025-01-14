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
  description = "IDs of all subnets created"
  value       = { for key, subnet in azurerm_subnet.main : key => subnet.id }
}