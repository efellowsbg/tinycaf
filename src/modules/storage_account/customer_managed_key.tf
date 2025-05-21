resource "azurerm_storage_account_customer_managed_key" "cmk" {

  count = (
    try(var.settings.customer_managed_key != null, false) &&
    try(var.settings.identity != null, false)
  ) ? 1 : 0

  storage_account_id = azurerm_storage_account.main.id
  key_vault_id       = try(var.resources.key_vault_keys[var.settings.customer_managed_key.key_vault_key_ref].key_vault_id, null)
  key_name           = try(var.resources.key_vault_keys[var.settings.customer_managed_key.key_vault_key_ref].key_name, null)
}
