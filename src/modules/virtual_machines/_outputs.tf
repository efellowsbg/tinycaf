output "windows_virtual_machines" {
  value = {
    for key, vm in module.virtual_machines :
    key => vm.windows_virtual_machines[0]
    if length(vm.windows_virtual_machines) > 0
  }
}

output "linux_virtual_machines" {
  value = {
    for key, vm in module.virtual_machines :
    key => vm.linux_virtual_machines[0]
    if length(vm.linux_virtual_machines) > 0
  }
}
