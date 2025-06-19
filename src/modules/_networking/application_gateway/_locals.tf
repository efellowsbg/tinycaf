locals {
  resource_group = var.resources[
    try(var.settings.resource_group_lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  public_ip = var.resources[
    try(var.settings.public_ip_lz_key, var.client_config.landingzone_key)
  ].public_ips[var.settings.public_ip]

  subnet = var.resources[
    try(var.settings.subnet_lz_key, var.client_config.landingzone_key)
  ].virtual_networks[
    var.settings.virtual_network
  ].subnets[
    split("/", var.settings.subnet_ref)[1]
  ]
}
