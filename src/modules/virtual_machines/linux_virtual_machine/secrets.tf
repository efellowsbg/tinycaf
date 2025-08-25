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


resource "random_password" "admin" {
  count            = try(var.settings.disable_password_authentication, false) ? 0 : 1
  length           = 18
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric          = true
  special          = true
  override_special = "!@#$%&"
}


resource "azurerm_key_vault_secret" "admin_password" {
  count        = try(var.settings.disable_password_authentication, false) ? 0 : 1
  name         = "${var.settings.name}-${var.settings.admin_username}"
  value        = random_password.admin[0].result
  key_vault_id = local.key_vault_id
}
