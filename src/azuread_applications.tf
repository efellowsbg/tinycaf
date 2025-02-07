data "azurerm_client_config" "current" {}

module "azuread_applications" {
  source   = "./modules/azuread_application"
  for_each = var.azuread_applications

  settings        = each.value
  global_settings = local.global_settings

  resources = {}
}
