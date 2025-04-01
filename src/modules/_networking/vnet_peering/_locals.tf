locals {
  vnet_left  = try(var.resources.virtual_networks[var.settings.vnet_left_ref], null)
  vnet_right = try(var.resources.virtual_networks[var.settings.vnet_right_ref], null)

  direction          = try(var.settings.direction, "<->")
  target             = local.direction == "target"
  source             = local.direction == "source"
  peer_left_to_right = endswith(local.direction, "->")
  peer_right_to_left = startswith(local.direction, "<-")

}
