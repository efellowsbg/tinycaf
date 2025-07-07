resource "azurerm_backup_policy_file_share" "fs" {
  for_each = try(var.settings.backup_policies.fs, {})

  name                = each.value.name
  resource_group_name = local.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.asr.name

  timezone = try(each.value.timezone, null)

  # required
  dynamic "retention_daily" {
    for_each = each.value.retention_daily

    content {
      count = each.value.retention_daily.count
    }
  }

  dynamic "backup" {
    for_each = can(each.value.backup) ? [1] : []

    content {
      frequency = each.value.backup.frequency
      time      = each.value.backup.time
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
