resource "azurerm_key_vault_secret" "private_key" {
  name         = "${var.settings.name}-ssh-private-key"
  value        = local.private_key
  key_vault_id = local.key_vault_id
}

resource "azurerm_key_vault_secret" "public_key" {
  name         = "${var.settings.name}-ssh-public-key"
  value        = local.public_key
  key_vault_id = local.key_vault_id
}
