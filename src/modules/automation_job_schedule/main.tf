resource "azurerm_automation_job_schedule" "main" {
  resource_group_name     = try(local.resource_group_name, var.settings.resource_group_name)
  automation_account_name = try(local.automation_account_name, var.settings.automation_account_name)
  runbook_name            = try(local.runbook_name, var.settings.runbook_name)
  schedule_name           = try(local.schedule_name, var.settings.schedule_name)
  parameters              = try(var.settings.parameters, null)
  run_on                  = try(var.settings.run_on, null)
}
