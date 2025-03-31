output "id" {
  value = azurerm_disk_encryption_set.main.id
}

output "key_vault_key_url" {
  value = azurerm_disk_encryption_set.main.key_vault_key_url
}

output "principal_id" {
  value = azurerm_disk_encryption_set.main.identity.0.principal_id
}

output "tenant_id" {
  value = azurerm_disk_encryption_set.main.identity.0.tenant_id
}
