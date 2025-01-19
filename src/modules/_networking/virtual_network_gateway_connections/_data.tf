data "azurerm_key_vault_secret" "main" {
  count       = var.settings.shared_key_secret != null ? 1 : 0
  name        = local.secret_name
  key_vault_id = local.keyvault_id
}
