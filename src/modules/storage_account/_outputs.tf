output "id" {
  value = azurerm_storage_account.main.id
}

output "name" {
  value = azurerm_storage_account.main.name
}
output "primary_access_key" {
  value = azurerm_storage_account.main.primary_access_key
  sensitive = true
}

output "primary_connection_string" {
  value = azurerm_storage_account.main.primary_connection_string
  sensitive = true
}

output "containers" {
  value = length(try(var.settings.containers, {})) > 0 ? {
    for container_ref, _ in try(var.settings.containers, {}) :
    container_ref => azurerm_storage_container.main[container_ref]
  } : null

  description = "Map of created Azure Storage Containers."
}
