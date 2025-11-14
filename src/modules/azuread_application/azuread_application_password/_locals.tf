locals {
  key_vault_id = try(
    var.resources[
      try(var.settings.create_client_secret.kv_lz_key, var.client_config.landingzone_key)
    ].keyvaults[var.settings.create_client_secret.keyvault_ref].id,
    try(var.settings.create_client_secret.key_vault_id, null)
  )

  tags = merge(
    var.global_settings.tags,
    try(var.settings.tags, {})
  )
}
