module "linux_virtual_machines" {
  source = "./linux_virtual_machine"

  count           = var.settings.type == "linux" ? 1 : 0
  settings        = var.settings
  global_settings = var.global_settings
  resources       = var.resources
  client_config   = var.client_config
}

module "windows_virtual_machines" {
  source = "./windows_virtual_machine"

  count           = var.settings.type == "windows" ? 1 : 0
  settings        = var.settings
  global_settings = var.global_settings
  resources       = var.resources
  client_config   = var.client_config
}

module "virtual_machines_default" {
  source = "./virtual_machine_default"

  count           = var.settings.type == "default" ? 1 : 0
  settings        = var.settings
  global_settings = var.global_settings
  resources       = var.resources
  client_config   = var.client_config
}
