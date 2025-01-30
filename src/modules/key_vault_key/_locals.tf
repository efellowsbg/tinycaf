locals {
  key_vault_id = var.resources.keyvaults[var.settings.key_vault_ref].id

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
