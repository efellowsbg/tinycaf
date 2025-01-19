data "azurerm_key_vault_secret" "main" {
  count = local.keyvault_ref != null && local.secret_name != null ? 1 : 0

  name         = local.secret_name
  key_vault_id = local.keyvault_id
}
