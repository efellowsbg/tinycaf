locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
  identity_ids = [
    for id_ref in try(var.settings.identity.identity_ids_ref, []) :
    var.resources[
      try(var.settings.identity.managed_identity_lz, var.client_config.landingzone_key)
    ].managed_identities[id_ref].id
  ]
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
}
