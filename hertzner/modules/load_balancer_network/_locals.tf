locals {
  load_balancer_id = var.resources[
    try(var.settings.load_balancer_lz_key, var.client_config.landingzone_key)
  ].load_balancers[var.settings.load_balancer_ref].id

  network_id = try(
    var.resources[
      try(var.settings.network_lz_key, var.client_config.landingzone_key)
    ].networks[var.settings.network_ref].id,
    null
  )

  subnet_id = try(
    var.resources[
      try(var.settings.subnet_lz_key, var.client_config.landingzone_key)
    ].network_subnets[var.settings.subnet_ref].id,
    null
  )
}
