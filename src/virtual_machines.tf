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
        public_ips           = module.public_ips
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


module "mssql_virtual_machines" {
  source   = "./modules/virtual_machines/mssql_virtual_machine"
  for_each = var.mssql_virtual_machines

  settings        = each.value
  global_settings = var.global_settings


  resources = merge(
    {
      (var.landingzone.key) = {
        linux_virtual_machines = {
          for key, vm in module.virtual_machines :
          key => vm.linux_virtual_machines[0]
          if length(vm.linux_virtual_machines) > 0
        }

        windows_virtual_machines = {
          for key, vm in module.virtual_machines :
          key => vm.windows_virtual_machines[0]
          if length(vm.windows_virtual_machines) > 0
        }
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
