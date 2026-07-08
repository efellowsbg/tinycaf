locals {
  volume_id = var.resources[
    try(var.settings.volume_lz_key, var.client_config.landingzone_key)
  ].volumes[var.settings.volume_ref].id

  server_id = var.resources[
    try(var.settings.server_lz_key, var.client_config.landingzone_key)
  ].servers[var.settings.server_ref].id
}
