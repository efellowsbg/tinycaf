module "azuread_service_principals" {
  source   = "./modules/azuread_service_principal"
  for_each = var.azuread_service_principals

  settings        = each.value
  global_settings = local.global_settings
  resources = merge(
    {
      (var.landingzone.key) = {
        azuread_applications = module.azuread_applications
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
  create_password = try(each.value.create_password, false)
}

