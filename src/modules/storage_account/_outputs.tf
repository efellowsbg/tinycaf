output "id" {
  value = azurerm_storage_account.main[each.key].id
}

output "containers" {
  value = {
    for container_ref, _ in try(var.settings.containers) :
    container_ref => azurerm_storage_container.main[container_ref]
  }
}
