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
  description = "IDs of all subnets grouped by VNet and Subnet"
  value = {
    for key, subnet in azurerm_subnet.main : 
    "${subnet.virtual_network_name}.${subnet.name}" => subnet.id
  }
}