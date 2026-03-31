module "automation_vm_schedules" {
  source          = "./modules/automation_vm_schedule"
  for_each        = var.automation_vm_schedules
  settings        = each.value
  global_settings = local.global_settings

  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
        automation_accounts  = module.automation_accounts
        automation_schedules = module.automation_schedules
        resource_groups      = module.resource_groups
        managed_identities   = module.managed_identities
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
