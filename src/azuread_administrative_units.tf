module "azuread_administrative_units" {
  source          = "./modules/azuread_administrative_unit"
  for_each        = var.azuread_administrative_units
  settings        = each.value
  global_settings = local.global_settings

  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
        # automation_accounts = module.automation_accounts
        # resource_groups     = module.resource_groups
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}
