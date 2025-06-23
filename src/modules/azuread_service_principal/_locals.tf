locals {
  client_id = try(
    var.resources[
      try(var.settings.lz_key, var.client_config.landingzone_key)
    ].azuread_applications[var.settings.client_id_ref],
    var.settings.client_id_ref
  )

  tags = merge(
    var.global_settings.tags,
    try(var.settings.tags, {})
  )
  

  key_vault_id = var.resources[
    try(var.settings.keyvault_lz_key, var.client_config.landingzone_key)
  ].key_vaults[var.settings.keyvault_ref].id

  keyvault_secret_name = try(var.settings.keyvault_secret_name, "client-secret")




}
