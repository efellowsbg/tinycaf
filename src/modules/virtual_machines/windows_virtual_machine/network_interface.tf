module "network_interface" {
  source          = "../network_interface"
  global_settings = var.global_settings
  settings        = var.settings

  resources     = var.resources
  client_config = var.client_config
}
