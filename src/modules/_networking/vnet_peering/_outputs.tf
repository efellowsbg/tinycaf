output "id" {
  value = {
    "left_to_right" = local.peer_left_to_right ? azurerm_virtual_network_peering.left_to_right[0].id : null
    "right_to_left" = local.peer_right_to_left ? azurerm_virtual_network_peering.right_to_left[0].id : null
  }
}
