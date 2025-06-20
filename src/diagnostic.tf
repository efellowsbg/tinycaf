module "diagnostic_setting" {
  source   = "./modules/monitoring/diagnostic_setting"

  settings  = var.diagnostic_setting
  resources = local.combined_resources

  client_config = {
    landingzone_key = var.landingzone.key
  }

  global_settings = local.global_settings
}
