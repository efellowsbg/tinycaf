module "diagnostic_setting" {
  source          = "../../modules/monitoring/diagnostic_setting"
  settings        = var.settings
  resources       = var.resources

  client_config = {
    landingzone_key = var.landingzone.key
  }

  global_settings = var.global_settings
}
