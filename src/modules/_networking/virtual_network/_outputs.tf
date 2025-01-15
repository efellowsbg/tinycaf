output "id" {
  value = azurerm_virtual_network.main.id
}

output "name" {
  value = azurerm_virtual_network.main.name
}

output "resource_group_name" {
  value = azurerm_virtual_network.main.resource_group_name
}

output "subnets" {
  description = "IDs of all subnets grouped by VNet and Subnet"
  value = {
    for subnet_ref, _ in var.settings.subnets :
    subnet_ref => azurerm_subnet.main[subnet_ref]
  }
}
