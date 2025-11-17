module "azuread_users" {
  source   = "./modules/azuread_user"
  for_each = var.azuread_users

  settings        = each.value
  global_settings = local.global_settings

  resources = merge(
    {
      (var.landingzone.key) = {
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
