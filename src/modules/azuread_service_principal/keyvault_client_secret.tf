resource "azurerm_key_vault_secret" "client_secret" {
  count = try(var.settings.use_keyvault, false) ? 1 : 0

  name         = local.keyvault_secret_name
  value        = azuread_service_principal_password.main.value
  key_vault_id = local.key_vault_id

  tags = try(local.tags, null)
}
