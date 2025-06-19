locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  public_ip = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].public_ips[var.settings.public_ip_key]

  subnet = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].virtual_networks[var.settings.vnet_key].subnets[var.settings.subnet_key]

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
