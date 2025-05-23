module "postgres" {
  source   = "./modules/postgres"
  for_each = var.postgres

  settings        = each.value
  global_settings = local.global_settings


  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups    = module.resource_groups
        managed_identities = module.managed_identities
        keyvaults          = module.keyvaults
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
