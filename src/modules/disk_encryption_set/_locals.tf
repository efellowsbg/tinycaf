locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
 ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  key_vault_key_id = var.resources.key_vault_keys[var.settings.key_vault_key_ref].versionless_id
  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
