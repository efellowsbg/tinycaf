data "azurerm_client_config" "current" {}

module "resource_groups" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  settings        = each.value
  global_settings = local.global_settings
}