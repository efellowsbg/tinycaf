module "key_vault_keys" {
  source   = "./modules/keyvault/key_vault_key"
  for_each = var.key_vault_keys

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups  = module.resource_groups
        keyvaults        = module.keyvaults
        virtual_networks = module.virtual_networks
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

