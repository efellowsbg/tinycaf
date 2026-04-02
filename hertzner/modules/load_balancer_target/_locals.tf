locals {
  load_balancer_id = var.resources[
    try(var.settings.load_balancer_lz_key, var.client_config.landingzone_key)
  ].load_balancers[var.settings.load_balancer_ref].id

  server_id = try(
    var.resources[
      try(var.settings.server_lz_key, var.client_config.landingzone_key)
    ].servers[var.settings.server_ref].id,
    null
  )
}
