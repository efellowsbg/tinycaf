module "mssql_servers" {
  source   = "./modules/mssql_server"
  for_each = var.mssql_servers

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups    = module.resource_groups
        managed_identities = module.managed_identities
        key_vault_keys     = module.key_vault_keys
        keyvaults          = module.keyvaults
        virtual_networks   = module.virtual_networks
        private_dns_zones  = module.private_dns_zones
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}


module "mssql_failover_group" {
  source   = "./modules/mssql_failover_group"
  for_each = var.mssql_failover_groups

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
        mssql_servers      = module.mssql_servers
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}


