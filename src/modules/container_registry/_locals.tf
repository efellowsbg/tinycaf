locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  dns_zone_group       = var.resources.private_dns_zones[var.settings.private_endpoint.private_dns_zone_group_ref]
  dns_zone_group_name  = local.dns_zone_group.name
  private_dns_zone_ids = [local.dns_zone_group.id]

  subnet_id = try(var.resources.virtual_networks[
    split("/", var.settings.private_endpoint.subnet_ref)[0]
    ].subnets[
    split("/", var.settings.private_endpoint.subnet_ref)[1]
  ].id, null)

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
