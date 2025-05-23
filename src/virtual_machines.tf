module "virtual_machines" {
  source   = "./modules/virtual_machines"
  for_each = var.virtual_machines

  settings        = each.value
  global_settings = var.global_settings


  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups      = module.resource_groups
        virtual_networks     = module.virtual_networks
        keyvaults            = module.keyvaults
        recovery_vaults      = module.recovery_vaults
        disk_encryption_sets = module.disk_encryption_sets
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

