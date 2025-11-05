locals {
  # key_vault_id = try(
  #   var.resources[
  #     try(var.settings.create_password.kv_lz_key, var.client_config.landingzone_key)
  #   ].module.keyvaults[var.settings.create_password.keyvault_ref].id,
  #   try(var.settings.create_password.key_vault_id, null)
  # )
  # key_vault_id = try(
  #   module.keyvaults[var.settings.create_password.keyvault_ref].id,
  #   try(var.settings.create_password.key_vault_id, null)
  # )

  tags = merge(
    var.global_settings.tags,
    try(var.settings.tags, {})
  )
}
