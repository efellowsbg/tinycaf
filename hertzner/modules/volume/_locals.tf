locals {
  labels = merge(
    try(var.global_settings.labels, {}),
    try(var.settings.labels, {})
  )

  server_id = try(
    var.resources[
      try(var.settings.server_lz_key, var.client_config.landingzone_key)
    ].servers[var.settings.server_ref].id,
    null
  )
}
