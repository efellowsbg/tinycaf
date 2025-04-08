output "linux_virtual_machines" {
  value = length(module.linux_virtual_machines) > 0 ? module.linux_virtual_machines[0].azurerm_linux_virtual_machine : []
}

output "windows_virtual_machines" {
  value = length(module.windows_virtual_machines) > 0 ? module.windows_virtual_machines[0].azurerm_windows_virtual_machine : []
}