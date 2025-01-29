locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  workspace_resource_id = var.resources.log_analytics_workspaces[var.settings.workspace_resource_ref].id

  destination_resource_id = var.resources.storage_accounts[var.settings.storage_account_ref].id

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
