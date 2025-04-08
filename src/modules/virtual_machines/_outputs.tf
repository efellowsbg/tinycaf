output "windows_virtual_machines" {
  value = length(module.windows_virtual_machines) > 0 ? {
    for idx in range(length(module.windows_virtual_machines)) :
    "windows_vm_${idx}" => module.windows_virtual_machines[idx]
  } : {}
}

output "linux_virtual_machines" {
  value = length(module.linux_virtual_machines) > 0 ? {
    for idx in range(length(module.linux_virtual_machines)) :
    "linux_vm_${idx}" => module.linux_virtual_machines[idx]
  } : {}
}
