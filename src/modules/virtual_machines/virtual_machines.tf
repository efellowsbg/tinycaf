module "linux_virtual_machine" {
  source = "./linux_virtual_machine"

  for_each = { for key, vm in var.settings : key => vm if vm.type == "linux" }

  settings        = each.value
  global_settings = var.global_settings

  resources = var.resources
}

module "windows_virtual_machine" {
  source = "./windows_virtual_machine"

  for_each = { for key, vm in var.settings : key => vm if vm.type == "windows" }

  settings        = each.value
  global_settings = var.global_settings

  resources = var.resources
}
