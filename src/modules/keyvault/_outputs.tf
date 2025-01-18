output "id" {
  value = azurerm_key_vault.main.id
}

output "vault_uri" {
  value = azurerm_key_vault.main.vault_uri
}

output "resource_group_name" {
  value = azurerm_key_vault.main.resource_group_name
}

output "location" {
  value = azurerm_key_vault.main.location
}

output "name" {
  value = azurerm_key_vault.main.name
}

output "key_vaults" {
  value = { for key, kv in azurerm_key_vault.main : key => kv }
}
