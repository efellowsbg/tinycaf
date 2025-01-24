output "ids" {
  value = tolist([for nic in azurerm_network_interface.main : nic.id])
}
