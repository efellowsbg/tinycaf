resource "azurerm_automation_schedule" "main" {
  name                    = var.settings.name
  frequency               = var.settings.frequency
  resource_group_name     = try(local.resource_group_name, var.settings.resource_group_name)
  automation_account_name = try(local.automation_account_name, var.settings.automation_account_name)
  description             = try(var.settings.description, null)
  interval                = try(var.settings.interval, null)
  start_time              = try(var.settings.start_time, null)
  expiry_time             = try(var.settings.expiry_time, null)
  timezone                = try(var.settings.timezone, null)
  week_days               = try(var.settings.week_days, null)
  month_days              = try(var.settings.month_days, null)

  dynamic "monthly_occurrence" {
    for_each = can(var.settings.monthly_occurrence) ? [1] : []
    content {
      day        = var.settings.monthly_occurrence.day
      occurrence = var.settings.monthly_occurrence.occurrence
    }
  }
}
