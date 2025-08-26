module "role_assignments" {
  source          = "./modules/role_assignments"
  settings        = var.role_assignments
  global_settings = local.global_settings
  subscription_id = var.subscription_id
  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups            = module.resource_groups
        keyvaults                  = module.keyvaults
        managed_identities         = module.managed_identities
        kubernetes_clusters        = module.kubernetes_clusters
        virtual_networks           = module.virtual_networks
        storage_accounts           = module.storage_accounts
        azuread_service_principals = module.azuread_service_principals
        azuread_applications       = module.azuread_applications
        role_definitions           = module.role_definitions
        disk_encryption_sets       = module.disk_encryption_sets
        container_registries       = module.container_registries
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


module "subscription_assignments" {
  source = "./modules/role_assignments/subscription"
  count = length(
    try(var.subscription_assignments.built_in_roles, [])
  ) > 0 ? 1 : 0

  subscription_assignments = var.subscription_assignments.built_in_roles
  global_settings          = local.global_settings

}
