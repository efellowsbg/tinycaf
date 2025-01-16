resource "azurerm_key_vault_access_policy" "logged_in_user" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = var.global_settings.tenant_id
  object_id    = var.global_settings.object_id

  secret_permissions = local.all_secret_permissions
  key_permissions    = local.all_key_permissions
}


