locals {

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )

  log_analytics_workspace_id = coalesce(
    try(var.resources[
      try(var.settings.log_analytics_lz_key, var.client_config.landingzone_key)
    ].log_analytics_workspaces[var.settings.log_analytics_ref].id, null),
    try(var.settings.log_analytics_workspace_id, null)
  )

  storage_account_id = coalesce(
    try(var.resources[
      try(var.settings.storage_account_lz_key, var.client_config.landingzone_key)
    ].storage_accounts[var.settings.storage_account_ref].id, null),
    try(var.settings.storage_account_id, null)
  )
}
