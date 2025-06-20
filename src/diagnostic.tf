module "diagnostic_setting" {
  source = "./modules/monitoring/diagnostic_setting"

  diagnostic_setting = var.diagnostic_setting
  resources          = var.resources
  global_settings    = local.global_settings

  client_config = {
    landingzone_key = var.landingzone.key
  }
}
