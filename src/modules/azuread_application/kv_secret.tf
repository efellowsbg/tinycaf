resource "azurerm_key_vault_secret" "main" {
  count = (
    try(var.settings.create_password, null) != null &&
    try(local.key_vault_id, null) != null
  ) ? 1 : 0

  name         = try(var.settings.create_password.secret_name, "${azuread_application.main.display_name}-client-secret")
  value        = azuread_application_password.main[0].value
  key_vault_id = local.key_vault_id

  depends_on = [
    azuread_application_password.main
  ]
}
