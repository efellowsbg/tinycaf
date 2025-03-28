locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location
  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
  identity_ids = [
    for id_ref in try(var.settings.identity.identity_ids_ref, []) :
    var.resources.managed_identities[id_ref].id
  ]
  has_encryption_identity = can(var.settings.encryption.managed_identity_ref)
  encryption_identity     = local.has_encryption_identity ? var.resources.managed_identities[var.settings.encryption.managed_identity_ref].id : null

  has_encryption = can(var.settings.encryption)
  encryption_key = local.has_encryption ? var.resources.key_vault_keys[var.settings.encryption.keyvault_key_ref].versionless_id : null
}
