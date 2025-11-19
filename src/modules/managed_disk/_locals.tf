locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  storage_account_id = try(
    var.resources[
      try(var.settings.stacc_lz_key, var.client_config.landingzone_key)
    ].storage_accounts[var.settings.storage_account_ref].id,
    try(var.settings.storage_account_id, null)
  )

  secret_url = try(
    var.resources[
      try(var.settings.encryption_settings.disk_encryption_key.lz_key, var.client_config.landingzone_key)
    ].keyvaults[var.settings.encryption_settings.disk_encryption_key.keyvault_ref].module.secrets[secret_ref].id,
    var.settings.encryption_settings.disk_encryption_key.secret_url
  )

  disk_source_vault_id = try(
    var.resources[
      try(var.settings.encryption_settings.disk_encryption_key.lz_key, var.client_config.landingzone_key)
    ].keyvaults[var.settings.encryption_settings.disk_encryption_key.keyvault_ref].id,
    var.settings.encryption_settings.disk_encryption_key.source_vault_id
  )

  key_url = try(
    var.resources[
      try(var.settings.encryption_settings.key_encryption_key.lz_key, var.client_config.landingzone_key)
    ].key_vault_keys[var.settings.encryption_settings.key_encryption_key.key_ref].versionless_id,
    var.settings.encryption_settings.key_encryption_key.key_url
  )

  key_source_vault_id = try(
    var.resources[
      try(var.settings.encryption_settings.key_encryption_key.lz_key, var.client_config.landingzone_key)
    ].keyvaults[var.settings.encryption_settings.key_encryption_key.keyvault_ref].id,
    var.settings.encryption_settings.key_encryption_key.key_source_vault_id
  )

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
