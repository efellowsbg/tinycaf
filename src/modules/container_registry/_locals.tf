locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  dns_zone_group = try(
    var.resources[
      try(var.settings.private_endpoint.dns_lz_key, var.client_config.landingzone_key)
    ].private_dns_zones[var.settings.private_endpoint.private_dns_zone_group_ref],
    null
  )
  dns_zone_group_name  = try(local.dns_zone_group.name, null)
  private_dns_zone_ids = try([local.dns_zone_group.id], null)

  subnet_id = try(
    var.resources[
      try(var.settings.private_endpoint.lz_key, var.client_config.landingzone_key)
      ].virtual_networks[
      split("/", var.settings.private_endpoint.subnet_ref)[0]
      ].subnets[
      split("/", var.settings.private_endpoint.subnet_ref)[1]
    ].id,
    null
  )

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
  identity_ids = [
    for id_ref in try(var.settings.identity.identity_ids_ref, []) :
    var.resources[
      var.client_config.landingzone_key
    ].managed_identities[id_ref].id
  ]
}
