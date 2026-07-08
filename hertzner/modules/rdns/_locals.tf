locals {
  server_id = try(
    var.resources[
      try(var.settings.server_lz_key, var.client_config.landingzone_key)
    ].servers[var.settings.server_ref].id,
    null
  )

  primary_ip_id = try(
    var.resources[
      try(var.settings.primary_ip_lz_key, var.client_config.landingzone_key)
    ].primary_ips[var.settings.primary_ip_ref].id,
    null
  )

  floating_ip_id = try(
    var.resources[
      try(var.settings.floating_ip_lz_key, var.client_config.landingzone_key)
    ].floating_ips[var.settings.floating_ip_ref].id,
    null
  )

  load_balancer_id = try(
    var.resources[
      try(var.settings.load_balancer_lz_key, var.client_config.landingzone_key)
    ].load_balancers[var.settings.load_balancer_ref].id,
    null
  )
}
