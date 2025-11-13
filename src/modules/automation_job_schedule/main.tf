resource "azurerm_automation_job_schedule" "main" {
  resource_group_name     = try(local.resource_group_name, var.settings.resource_group_name)
  automation_account_name = try(local.automation_account_name, var.settings.automation_account_name)
  runbook_name            = try(local.runbook_name, var.settings.runbook_name)
  schedule_name           = try(local.schedule_name, var.settings.schedule_name)
  run_on                  = try(var.settings.run_on, null)

  dynamic "parameters" {
    for_each = try(values(var.settings.parameters), {})
    content {
      key           = lower(parameters.value.key) # lowercase enforced
      type          = parameters.value.type
      mandatory     = try(parameters.value.mandatory, null)
      position      = try(parameters.value.position, null)
      default_value = try(parameters.value.default_value, null)
    }
  }
}
