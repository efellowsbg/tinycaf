locals {
  client_id = try(
    var.resources[
      try(var.settings.lz_key, var.client_config.landingzone_key)
    ].azuread_applications[var.settings.client_id_ref].client_id,
    var.settings.client_id
  )

  tags = merge(
    var.global_settings.tags,
    try(var.settings.tags, {})
  )
}
