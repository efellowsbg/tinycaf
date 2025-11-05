resource "azurerm_key_vault_secret" "main" {
  count = local.key_vault_id == null ? 0 : 1

  name         = try(var.settings.create_password.secret_name, "${azuread_application.main.display_name}-client-secret")
  value        = azuread_application_password.main[0].value
  key_vault_id = local.key_vault_id
}
