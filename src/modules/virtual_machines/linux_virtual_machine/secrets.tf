resource "azurerm_key_vault_secret" "private_keys" {
  for_each     = local.private_keys_pem
  name         = "${var.settings.name}-${replace(each.key, "_", "-")}-ssh-private-key"
  value        = each.value
  key_vault_id = local.key_vault_id
}

resource "azurerm_key_vault_secret" "public_keys" {
  for_each     = local.public_keys_openssh
  name         = "${var.settings.name}-${replace(each.key, "_", "-")}-ssh-public-key"
  value        = each.value
  key_vault_id = local.key_vault_id
}
