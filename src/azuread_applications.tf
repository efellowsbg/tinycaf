module "azuread_applications" {
  source   = "./modules/azuread_application"
  for_each = var.azuread_applications

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}
