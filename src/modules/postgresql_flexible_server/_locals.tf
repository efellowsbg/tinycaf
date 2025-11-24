locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  delegated_subnet_id = try(
    var.resources[
      try(var.settings.vnet_lz_key, var.client_config.landingzone_key)
      ].virtual_networks[
      split("/", var.settings.subnet_ref)[0]
      ].subnets[
      split("/", var.settings.subnet_ref)[1]
    ].id,
    var.settings.delegated_subnet_id,
    null
  )

  private_dns_zone_id = try(
    var.resources[
      try(var.settings.dnszone_lz_key, var.client_config.landingzone_key)
      ].private_dns_zones[
      var.settings.dnszone_ref
    ].id,
    var.settings.private_dns_zone_id,
    null
  )

  key_vault_key_id = try(
    var.resources[
      try(var.settings.customer_managed_key.kvkey_lz_key, var.client_config.landingzone_key)
      ].key_vault_keys[
      var.settings.customer_managed_key.kvkey_ref
    ].versionless_id,
    var.settings.customer_managed_key.key_vault_key_id
  )

  geo_backup_key_vault_key_id = try(
    var.resources[
      try(var.settings.customer_managed_key.geo_kvkey_lz_key, var.client_config.landingzone_key)
      ].key_vault_keys[
      var.settings.customer_managed_key.geo_kvkey_ref
    ].versionless_id,
    var.settings.customer_managed_key.geo_backup_key_vault_key_id
  )

  primary_user_assigned_identity_id = try(
    var.resources[
      try(var.settings.customer_managed_key.prime_mi_lz_key, var.client_config.landingzone_key)
      ].managed_identities[
      var.settings.customer_managed_key.prime_mi_ref
    ].id,
    var.settings.customer_managed_key.primary_user_assigned_identity_id
  )

  geo_backup_user_assigned_identity_id = try(
    var.resources[
      try(var.settings.customer_managed_key.geo_mi_lz_key, var.client_config.landingzone_key)
      ].managed_identities[
      var.settings.customer_managed_key.geo_mi_ref
    ].id,
    var.settings.customer_managed_key.geo_backup_user_assigned_identity_id
  )

  identity_ids = [
    for id_ref in try(var.settings.identity.identity_ids_ref, []) :
    var.resources[
      try(var.settings.identity.mi_lz_key, var.client_config.landingzone_key)
    ].managed_identities[id_ref].id
  ]

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
