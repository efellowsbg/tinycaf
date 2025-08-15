locals {
  vnet_left = try(
    var.resources[
      try(var.settings.vnet_left_lz_key, var.client_config.landingzone_key)
    ].virtual_networks[var.settings.vnet_left_ref],
    null
  )

  vnet_right = try(
    var.resources[
      try(var.settings.vnet_right_lz_key, var.client_config.landingzone_key)
    ].virtual_networks[var.settings.vnet_right_ref],
    null
  )


  direction = try(var.settings.direction, "<->")
  target    = local.direction == "target"
  source    = local.direction == "source"
  custom = local.direction == "custom"

  # These use regex to simulate startswith/endswith
  peer_left_to_right = can(regex("->$", local.direction))
  peer_right_to_left = can(regex("^<-", local.direction))
}
