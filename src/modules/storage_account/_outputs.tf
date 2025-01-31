output "id" {
  value = azurerm_storage_account.main.id
}

output "containers" {
  value = length(try(var.settings.containers, {})) > 0 ? {
    for container_ref, _ in try(var.settings.containers, {}) :
    container_ref => azurerm_storage_container.main[container_ref]
  } : null

  description = "Map of created Azure Storage Containers."
}
