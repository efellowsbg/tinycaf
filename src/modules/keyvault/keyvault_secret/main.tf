resource "azurerm_key_vault_secret" "main" {
  name         = var.secrets.name
  value        = var.secrets.value
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = var.secrets.ignore_changes ? [value] : []
  }
}
