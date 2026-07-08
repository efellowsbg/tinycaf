locals {
  firewall_id = var.resources[
    try(var.settings.firewall_lz_key, var.client_config.landingzone_key)
  ].firewalls[var.settings.firewall_ref].id

  server_ids = try([
    for ref in var.settings.server_ids_ref :
    var.resources[
      try(var.settings.server_lz_key, var.client_config.landingzone_key)
    ].servers[ref].id
  ], null)
}
