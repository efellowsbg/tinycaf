module "azuread_service_principals" {
  source   = "./modules/azuread_service_principal"
  for_each = var.azuread_service_principals

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    azuread_applications = module.azuread_applications
  }
}
