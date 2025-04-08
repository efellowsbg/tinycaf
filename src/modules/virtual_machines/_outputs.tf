output "linux_virtual_machines" {
  value = module.linux_virtual_machines.azurerm_linux_virtual_machine
}

output "windows_virtual_machines" {
  value = module.windows_virtual_machines.azurerm_windows_virtual_machine
}