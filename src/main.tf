data "azurerm_client_config" "current" {}

module "resource_groups" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }

}
module "diagnostic_setting" {
  source = "./modules/monitoring/diagnostic_setting"

  settings  = var.diagnostic_setting
  resources = var.resources

  client_config = {
    landingzone_key = var.landingzone.key
  }

  global_settings = local.global_settings
}
