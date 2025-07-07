output "id" {
  value = {
    "left_to_right" = try(local.peer_left_to_right ? azurerm_virtual_network_peering.left_to_right[0].id : null, null)
    "right_to_left" = try(local.peer_right_to_left ? azurerm_virtual_network_peering.right_to_left[0].id : null, null)
    "target"        = try(local.target ? azurerm_virtual_network_peering.target[0].id : null, null)
    "source"        = try(local.source ? azurerm_virtual_network_peering.source[0].id : null, null)
  }
}
