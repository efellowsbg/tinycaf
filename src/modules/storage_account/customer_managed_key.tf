resource "azurerm_storage_account_customer_managed_key" "cmk" {

  count = try(var.settings.cmk_key != null, false) ? 1 : 0

  storage_account_id = azurerm_storage_account.main.id
  key_vault_id       = try(var.resources.key_vault_keys[var.settings.cmk_key].key_vault_id, null)
  key_name           = try(var.resources.key_vault_keys[var.settings.cmk_key].name, null)
}
