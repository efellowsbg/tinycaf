output "ids" {
  value = [for nic in azurerm_network_interface.main : nic.id]
}
