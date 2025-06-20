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
module "diagnostic_settings" {
  source          = "./modules/diagnostic_settings"
  settings        = var.settings
  resources       = var.resources
  client_config   = var.client_config
  global_settings = var.global_settings
}
