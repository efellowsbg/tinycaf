
locals {
  # resource group
  resource_group = var.resources[
    try(var.settings.resource_group_lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location
  # identity
  identity_ids = [
    for id_ref in try(var.settings.identity.identity_ids_ref, []) :
    var.resources[
      try(var.settings.identity.managed_identity_lz, var.client_config.landingzone_key)
    ].managed_identities[id_ref].id
  ]

  # subnet
  subnet_id = try(
    var.resources[
      try(var.settings.site_config.ip_restriction.subnet_lz_key, var.client_config.landingzone_key)
      ].virtual_networks[
      split("/", var.settings.site_config.ip_restriction.subnet_ref)[0]
      ].subnets[
      split("/", var.settings.site_config.ip_restriction.subnet_ref)[1]
    ].id,
    null
  )

  # key vault key
  key_vault_key_id = var.resources[
    try(var.settings.key_vault_key_lz_key, var.client_config.landingzone_key)
    ].key_vault_keys[
    var.settings.key_vault_key_ref
  ].versionless_id
}
