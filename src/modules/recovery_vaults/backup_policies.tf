resource "azurerm_backup_policy_vm" "vm" {
  for_each = try(var.settings.backup_policies.vms, {})

  name                           = each.value.name
  resource_group_name            = local.resource_group_name
  recovery_vault_name            = azurerm_recovery_services_vault.asr.name
  instant_restore_retention_days = try(each.value.instant_restore_retention_days, null)
  timezone                       = try(each.value.timezone, null)
  policy_type                    = try(each.value.is_enhanced_policy, false) ? "V2" : "V1"

  dynamic "backup" {
    for_each = can(each.value.backup) ? [1] : []

    content {
      time      = each.value.backup.time
      frequency = try(each.value.backup.frequency, null)
      weekdays  = try(each.value.backup.weekdays, null)
    }
  }

  dynamic "retention_daily" {
    for_each = can(each.value.retention_daily) ? [1] : []

    content {
      count = each.value.retention_daily.count
    }
  }

  dynamic "retention_weekly" {
    for_each = can(each.value.retention_weekly) ? [1] : []

    content {
      count    = each.value.retention_weekly.count
      weekdays = each.value.retention_weekly.weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = can(each.value.retention_monthly) ? [1] : []

    content {
      count    = each.value.retention_monthly.count
      weekdays = each.value.retention_monthly.weekdays
      weeks    = each.value.retention_monthly.weeks
    }
  }

  dynamic "retention_yearly" {
    for_each = can(each.value.retention_yearly) ? [1] : []

    content {
      count    = each.value.retention_yearly.count
      weekdays = each.value.retention_yearly.weekdays
      weeks    = each.value.retention_yearly.weeks
      months   = each.value.retention_yearly.months
    }
  }
}
