output "windows_virtual_machines" {
  value = length(module.windows_virtual_machines) > 0 ? [module.windows_virtual_machines[0].id] : []
}

output "linux_virtual_machines" {
  value = length(module.linux_virtual_machines) > 0 ? [module.linux_virtual_machines[0].id] : []
}
