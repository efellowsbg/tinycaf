resource "azurerm_automation_runbook" "start" {
  for_each = length(try(var.settings.start_schedules, [])) > 0 ? local.vms : {}

  name                    = "start-vm-${replace(each.key, "_", "-")}"
  runbook_type            = "PowerShell72"
  log_progress            = try(var.settings.log_progress, true)
  log_verbose             = try(var.settings.log_verbose, true)
  resource_group_name     = local.resource_group_name
  location                = local.location
  automation_account_name = local.automation_account_name
  tags                    = local.tags
  description             = "Start VM ${each.value.name}"
  content                 = local.start_content

  dynamic "job_schedule" {
    for_each = var.settings.start_schedules
    content {
      schedule_name = var.resources[
        try(var.settings.schedule_lz_key, var.client_config.landingzone_key)
      ].automation_schedules[job_schedule.value].name
      parameters = local.job_parameters[each.key]
    }
  }
}

resource "azurerm_automation_runbook" "stop" {
  for_each = length(try(var.settings.stop_schedules, [])) > 0 ? local.vms : {}

  name                    = "stop-vm-${replace(each.key, "_", "-")}"
  runbook_type            = "PowerShell72"
  log_progress            = try(var.settings.log_progress, true)
  log_verbose             = try(var.settings.log_verbose, true)
  resource_group_name     = local.resource_group_name
  location                = local.location
  automation_account_name = local.automation_account_name
  tags                    = local.tags
  description             = "Stop VM ${each.value.name}"
  content                 = local.stop_content

  dynamic "job_schedule" {
    for_each = var.settings.stop_schedules
    content {
      schedule_name = var.resources[
        try(var.settings.schedule_lz_key, var.client_config.landingzone_key)
      ].automation_schedules[job_schedule.value].name
      parameters = local.job_parameters[each.key]
    }
  }
}
