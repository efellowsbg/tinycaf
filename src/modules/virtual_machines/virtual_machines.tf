module "linux_virtual_machine" {
  source = "./linux_virtual_machine"

  count           = var.settings.type == "linux" ? 1 : 0
  settings        = var.settings
  global_settings = var.global_settings
  resources       = var.resources
}

module "windows_virtual_machine" {
  source = "./windows_virtual_machine"

  count           = var.settings.type == "windows" ? 1 : 0
  settings        = var.settings
  global_settings = var.global_settings
  resources       = var.resources
}
