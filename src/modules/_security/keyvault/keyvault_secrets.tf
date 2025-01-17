resource "azurerm_key_vault_secret" "main" {
  for_each = {
    for key, value in try(var.settings.secrets, {}) : key => value
    if try(value.ignore_changes, false) == false
  }
  name         = each.value.name
  value        = ""
  key_vault_id = azurerm_key_vault.main.id

  lifecycle {
    ignore_changes = [value]
  }
}
