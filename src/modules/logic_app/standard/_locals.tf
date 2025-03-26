locals {
  resource_group                     = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name                = local.resource_group.name
  location                           = local.resource_group.location
  app_service_plan_id                = var.resources.app_service_plans[var.settings.app_service_plan_ref].id
  storage_account_name               = var.resources.storage_accounts[var.settings.storage_account_ref].name
  storage_account_primary_access_key = var.resources.storage_accounts[var.settings.storage_account_ref].primary_access_key

  content = {
    for key, value in var.settings.app_settings :
    key => value
  }

  identity_ids = [
    for id_ref in try(var.settings.identity.identity_ids_ref, []) :
    var.resources.managed_identities[id_ref].id
  ]

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
