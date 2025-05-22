locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref].name
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  workspace     = var.resources.log_analytics_workspaces[var.settings.diagnostics.log_analitics.workspace_ref]
  workspace_id  = local.workspace.id
  workspace_key = local.workspace.primary_shared_key

  key_vault_key_id = var.resources.key_vault_keys[var.settings.key_vault_key_ref].resource_versionless_id

  identity_ids = [
    for id_ref in try(var.settings.identity.identity_ids_ref, []) :
    var.resources.managed_identities[id_ref].id
  ]

  subnet_ids = [
    for config in try(var.settings.subnet_idsbnets, []) : (
      var.resources.virtual_networks[split("/", config.subnet_ref)[0]].subnets[split("/", config.subnet_ref)[1]].id
    )
  ]

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
