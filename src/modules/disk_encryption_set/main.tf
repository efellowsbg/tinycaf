resource "azurerm_disk_encryption_set" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  key_vault_key_id = try(local.key_vault_key_id, null)
  identity {
    type = "SystemAssigned"
  }
  auto_key_rotation_enabled = = try(var.settings.auto_key_rotation_enabled, false)
}
