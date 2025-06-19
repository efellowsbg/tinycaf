locals {
  resource_group = var.resources[
    try(var.settings.resource_group_lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  first_frontend_ip_key = keys(var.settings.frontend_ip_configuration)[0]

  public_ip = var.resources[
    try(var.settings.frontend_ip_configuration[local.first_frontend_ip_key].lz_key, var.client_config.landingzone_key)
  ].public_ips[
    var.settings.frontend_ip_configuration[local.first_frontend_ip_key].public_ip
  ]

  subnet = var.resources[
    try(var.settings.subnet_lz_key, var.client_config.landingzone_key)
  ].virtual_networks[
    var.settings.virtual_network
  ].subnets[
    split("/", var.settings.subnet_ref)[1]
  ]

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
