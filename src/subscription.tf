module "subscriptions" {
  source          = "./modules/subscription"
  for_each        = var.subscriptions
  settings        = each.value
  global_settings = local.global_settings

  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
        # resource_groups    = module.resource_groups
        # managed_identities = module.managed_identities
        # key_vault_keys     = module.key_vault_keys
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}
