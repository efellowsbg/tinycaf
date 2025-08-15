module "ssh_keys" {
  source   = "./modules/ssh_key"
  for_each = var.ssh_keys

  settings         = each.value
  global_settings  = local.global_settings
  save_to_keyvault = try(each.value.keyvault_ref, false)

  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups = module.resource_groups
        keyvaults       = module.keyvaults
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
