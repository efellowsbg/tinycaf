module "automation_runbooks" {
  source          = "./modules/automation_runbook"
  for_each        = var.automation_runbooks
  settings        = each.value
  global_settings = local.global_settings

  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
        automation_accounts  = module.automation_accounts
        resource_groups      = module.resource_groups
        managed_identities   = module.managed_identities
        automation_schedules = module.automation_schedules
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
        virtual_machines_default = {
          for key, vm in module.virtual_machines :
          key => vm.virtual_machines_default[0]
          if length(vm.virtual_machines_default) > 0
        }
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}
