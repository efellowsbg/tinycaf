resource "azuread_service_principal_password" "main" {
  count                = var.create_password ? 1 : 0
  service_principal_id = azuread_service_principal.main.id
}

resource "azurerm_key_vault_secret" "main" {
  count = var.create_password ? 1 : 0
  name  = azuread_service_principal.main.display_name
  value = azuread_service_principal_password.main[count.index].value
  key_vault_id = try(
    var.resources[
      try(var.settings.keyvault_lz_key, var.client_config.landingzone_key)
      ].keyvaults[
      var.settings.keyvault_ref
    ].id,
    null
  )
}
