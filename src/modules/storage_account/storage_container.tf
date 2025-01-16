resource "azurerm_storage_container" "main" {
  name                  = var.settings.storage_container.name
  storage_account_id    = local.storage_account_id
  container_access_type = try(var.settings.storage_container.container_access_type, null)
}
