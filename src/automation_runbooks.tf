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
        automation_accounts = module.automation_accounts
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}
