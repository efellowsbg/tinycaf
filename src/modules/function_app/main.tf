module "linux_function_apps" {
  source = "./linux_function_app"

  count           = var.settings.type == "linux" ? 1 : 0
  settings        = var.settings
  global_settings = var.global_settings
  resources       = var.resources
  client_config   = var.client_config
}

module "windows_function_apps" {
  source = "./windows_function_app"

  count           = var.settings.type == "windows" ? 1 : 0
  settings        = var.settings
  global_settings = var.global_settings
  resources       = var.resources
  client_config   = var.client_config
}
