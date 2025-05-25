locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  current_module       = try(var.settings.private_service_connection.resource_type, null)
  current_resource_ref = try(var.settings.private_service_connection.resource_ref, null)

  subnet_id = try(
    var.resources[
      try(var.settings.subnet_lz_key, var.client_config.landingzone_key)
    ].virtual_networks[split("/", var.settings.subnet_ref)[0]].subnets[split("/", var.settings.subnet_ref)[1]].id,
    var.settings.subnet_ref
  )


  private_connection_resource_id = try(
    var.resources[
      try(var.settings.lz_key, var.client_config.landingzone_key)
    ][local.current_resource_ref].id,
    var.settings.resource_ref
  )



  private_dns_zone_ids = try([
    for dns_zone_ref in try(var.settings.private_dns_zone_group.private_dns_zone_refs, []) :
    var.resources[
      try(var.settings.private_dns_zone_group.lz_key, var.client_config.landingzone_key)
    ].private_dns_zones[dns_zone_ref].id
  ], var.settings.private_dns_zone_group.private_dns_zone_ids)
  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
