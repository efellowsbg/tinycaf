locals {
  labels = merge(
    try(var.global_settings.labels, {}),
    try(var.settings.labels, {})
  )

  zone_id = var.resources[
    try(var.settings.zone_lz_key, var.client_config.landingzone_key)
  ].zones[var.settings.zone_ref].id
}
