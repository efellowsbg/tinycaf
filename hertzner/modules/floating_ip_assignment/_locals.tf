locals {
  floating_ip_id = var.resources[
    try(var.settings.floating_ip_lz_key, var.client_config.landingzone_key)
  ].floating_ips[var.settings.floating_ip_ref].id

  server_id = var.resources[
    try(var.settings.server_lz_key, var.client_config.landingzone_key)
  ].servers[var.settings.server_ref].id
}
