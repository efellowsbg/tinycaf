resource "azurerm_ssh_public_key" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  public_key          = tls_private_key.main.public_key_openssh
}


resource "tls_private_key" "main" {

  algorithm = try(var.settings.algorithm, "RSA")
  rsa_bits  = try(var.settings.rsa_bits, 4096)
}


resource "azurerm_key_vault_secret" "main" {
  count        = var.save_to_keyvault ? 1 : 0
  name         = "${var.settings.name}-ssh-public-key"
  value        = tls_private_key.main.public_key_openssh
  key_vault_id = try(
    var.resources[
      try(var.settings.keyvault_lz_key, var.client_config.landingzone_key)
    ].keyvaults[
      var.settings.keyvault_ref
    ].id,
    null
  )
}