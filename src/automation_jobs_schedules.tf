module "automation_jobs_schedules" {
  source          = "./modules/automation_job_schedule"
  for_each        = var.automation_jobs_schedules
  settings        = each.value
  global_settings = local.global_settings

  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups      = module.resource_groups
        automation_accounts  = module.automation_accounts
        automation_schedules = module.automation_schedules
        automation_runbooks  = module.automation_runbooks
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}
