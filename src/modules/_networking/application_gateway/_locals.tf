locals {
  lz_key = try(var.settings.lz_key, var.client_config.landingzone_key)

  resource_group = var.resources[local.lz_key].resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  public_ip = var.resources[local.lz_key].public_ips[var.settings.public_ip]

  subnet = var.resources[local.lz_key].virtual_networks[var.settings.virtual_network].subnets[
    split("/", var.settings.subnet_ref)[1]
  ]

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
