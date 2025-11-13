module "automation_accounts" {
  source          = "./modules/automation_account"
  for_each        = var.automation_accounts
  settings        = each.value
  global_settings = local.global_settings

  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
        managed_identities = var.managed_identities
        key_vault_keys     = var.key_vault_keys
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}
