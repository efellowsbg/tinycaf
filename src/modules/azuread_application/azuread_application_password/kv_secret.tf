resource "azurerm_key_vault_secret" "main" {
  count = try(local.key_vault_id, null) != null ? 1 : 0

  name         = var.settings.create_password.secret_name
  value        = azuread_application_password.main[0].value
  key_vault_id = local.key_vault_id
}
