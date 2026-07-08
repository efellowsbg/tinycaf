locals {
  network_id = var.resources[
    try(var.settings.network_lz_key, var.client_config.landingzone_key)
  ].networks[var.settings.network_ref].id
}
