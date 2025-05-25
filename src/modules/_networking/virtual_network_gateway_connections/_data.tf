data "azurerm_key_vault_secret" "main" {
  count = var.settings.shared_key_secret != null ? 1 : 0
  name  = try(element(split("/", var.settings.shared_key_secret), 1), null)

  key_vault_id = try(
    var.resources[
      try(var.settings.shared_key_lz_key, var.client_config.landingzone_key)
    ].keyvaults[element(split("/", var.settings.shared_key_secret), 0)].id,
    null
  )
}
