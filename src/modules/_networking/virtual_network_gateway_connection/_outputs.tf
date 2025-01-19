output "id" {
  value = azurerm_virtual_network_gateway_connection.main.id
}

output "secret_value" {
  value     = data.azurerm_key_vault_secret.main.value
  sensitive = true
}
