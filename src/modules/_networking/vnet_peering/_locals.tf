locals {
  vnet_left  = var.resources.virtual_networks[var.settings.vnet_left_ref]
  vnet_right = var.resources.virtual_networks[var.settings.vnet_right_ref]

  direction = try(var.settings.direction, "<->")

  peer_left_to_right = endswith(local.direction, "->")
  peer_right_to_left = startswith(local.direction, "<-")
}
