locals {
  subnet_id = try(
    var.resources.virtual_networks[split("/", var.settings.private_endpoint.subnet_ref)[0]].subnets[split("/", var.settings.private_endpoint.subnet_ref)[1]].id,
    null
  )
  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )

  resource_group = var.resources.resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location
}

locals {
  dns_zone_ids = try([
    for zone in var.settings.private_endpoint.dns_zones_ref :
    var.resources.private_dns_zones[zone].id
  ], [])
}
