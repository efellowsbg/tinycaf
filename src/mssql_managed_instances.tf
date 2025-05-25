module "mssql_managed_instances" {
  source   = "./modules/mssql_managed_instance"
  for_each = var.mssql_managed_instances

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups         = module.resource_groups
        virtual_networks        = module.virtual_networks
        managed_identities      = module.managed_identities
        network_security_groups = module.network_security_groups
        keyvaults               = module.keyvaults
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
