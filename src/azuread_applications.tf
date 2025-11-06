module "azuread_applications" {
  source          = "./modules/azuread_application"
  for_each        = var.azuread_applications
  settings        = each.value
  global_settings = local.global_settings

  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}

module "azuread_application_passwords" {
  source = "./modules/azuread_application/azuread_application_password"
  count  = try(var.azuread_applications.create_password, null) == null ? 0 : 1
  # for_each = var.azuread_applications
  settings        = var.azuread_applications
  global_settings = local.global_settings

  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
        keyvaults = module.keyvaults
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}
