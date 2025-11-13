locals {
  resource_group_name = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref].name

  automation_account_name = var.resources[
    try(var.settings.acc_lz_key, var.client_config.landingzone_key)
  ].automation_accounts[var.settings.acc_ref].name

  runbook_name = var.resources[
    try(var.settings.runbook_lz_key, var.client_config.landingzone_key)
  ].automation_runbooks[var.settings.runbook_ref].name

  schedule_name = var.resources[
    try(var.settings.schedule_lz_key, var.client_config.landingzone_key)
  ].automation_schedules[var.settings.schedule_ref].name

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
