locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  network_interface_ids = module.network_interface.ids
  key_vault_id = try(var.resources[
    try(var.settings.os_profile.keyvault_lz_key, var.client_config.landingzone_key)
    ].keyvaults[
    var.settings.os_profile.keyvault_ref
  ].id, null)
  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
  identity_ids = [
    for id_ref in try(var.settings.identity.identity_ids_ref, []) :
    var.resources[
      try(var.settings.identity.managed_identity_lz_key, var.client_config.landingzone_key)
    ].managed_identities[id_ref].id
  ]
  create_managed_disk = try(coalesce(var.settings.storage_os_disk.create_disk, false), false)
}
