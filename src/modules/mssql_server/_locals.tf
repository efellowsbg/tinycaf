locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  transparent_data_encryption_key_vault_key_id = try(
    var.resources[
      try(var.settings.kvkey_lz_key, var.client_config.landingzone_key)
    ].key_vault_keys[var.settings.kvkey_ref].versionless_id,
    try(var.settings.transparent_data_encryption_key_vault_key_id, null)
  )

  identity_ids = [
    for id_ref in try(var.settings.identity.identity_ids_ref, []) :
    var.resources[
      try(var.settings.identity.mi_lz_key, var.client_config.landingzone_key)
    ].managed_identities[id_ref].id
  ]

  primary_user_assigned_identity_id = try(
    var.resources[
      try(var.settings.prime_mi_lz_key, var.client_config.landingzone_key)
    ].managed_identities[var.settings.prime_mi_ref].id,
    try(var.settings.primary_user_assigned_identity_id, null)
  )

  key_vault_id = try(
    var.resources[
      try(var.settings.key_vault_lz_key, var.client_config.landingzone_key)
      ].keyvaults[
      var.settings.key_vault_ref
    ].id,
    null
  )
  use_lifecycle = try(var.settings.use_lifecycle, false)
  administrator_login_password = try(
    (
      try(length(trimspace(var.settings.key_vault_ref)) > 0, false)
      ? random_password.admin[0].result
      : try(var.settings.administrator_login_password, random_password.admin[0].result)
    ),
    null
  )

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
