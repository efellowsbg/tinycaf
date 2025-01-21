module "network_interface" {
  source          = "../network_interface"
  for_each        = var.settings.network_interfaces
  global_settings = var.global_settings
  all_settings    = var.settings
  settings        = each.value


  resources = var.resources
}
