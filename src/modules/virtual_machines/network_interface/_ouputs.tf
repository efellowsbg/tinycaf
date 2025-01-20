output "nics" {
  value = {
    for _, nic in try(var.settings.network_interface_ids) :
    nic.nic_ref => azurerm_network_interface.main[nic.nic_ref]
  }
}

output "nic_id" {
  value = azurerm_network_interface.main.id
}
