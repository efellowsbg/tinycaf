output "id" {
  value = azurerm_virtual_network_gateway.main.id
}

output "nat_rule_ids" {
  value = {
    for k, v in azurerm_virtual_network_gateway_nat_rule.main : k => v.id
  }
}
