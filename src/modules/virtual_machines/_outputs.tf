output "windows_virtual_machines" {
  value = length(module.windows_virtual_machines) > 0 ? {
    for key, vm in module.windows_virtual_machines :
    key => vm
    if length(vm) > 0
  } : {}
}

output "linux_virtual_machines" {
  value = length(module.linux_virtual_machines) > 0 ? {
    for key, vm in module.linux_virtual_machines :
    key => vm
    if length(vm) > 0
  } : {}
}
