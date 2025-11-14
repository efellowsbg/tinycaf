resource "azurerm_key_vault_secret" "main" {
  count = try(local.key_vault_id, null) != null ? 1 : 0

  name         = try(var.settings.create_client_secret.secret_name, "client-secret-${var.application_name}")
  value        = azuread_application_password.main.value
  key_vault_id = local.key_vault_id
}
