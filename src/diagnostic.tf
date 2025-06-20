module "diagnostic_setting" {
  source   = "./modules/monitoring/diagnostic_setting"
  for_each = var.diagnostic_settings  # This must be a map

  diagnostic_setting = each.value
  resources          = var.resources
  global_settings    = local.global_settings

  client_config = {
    landingzone_key = var.landingzone.key
  }
}
