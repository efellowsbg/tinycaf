output "id" {
  value = azurerm_virtual_network_gateway_connection.main.id
}

output "secret_value" {
  value = length(data.azurerm_key_vault_secret.main) > 0 ? data.azurerm_key_vault_secret.main[0].value : null
}
