resource "azurerm_key_vault_secret" "main" {
  name         = "${var.settings.name}-ssh-private-key"
  value        = local.public_key
  key_vault_id = local.key_vault_id
}
