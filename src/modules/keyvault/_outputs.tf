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

output "debug_subnet_resolution" {
  value = local.resolved_subnet_ids
}