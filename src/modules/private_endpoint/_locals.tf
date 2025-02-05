locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  subnet_id = try(
    var.resources.virtual_networks[split("/", var.settings.subnet_ref)[0]].subnets[split("/", var.settings.subnet_ref)[1]].id,
    null
  )

  private_connection_resource_id = var.resources[var.settings.private_service_connection.resource_type][var.settings.private_service_connection.resource_ref].id

  private_dns_zone_ids = [
    for dns_zone_ref in try(var.settings.private_dns_zone_group.private_dns_zone_refs, []) :
    var.resources.private_dns_zones[dns_zone_ref].id
  ]

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
