locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  virtual_network_id = try(
    var.resources[
      try(var.settings.private_endpoint.lz_key, var.client_config.landingzone_key)
    ].virtual_networks[var.settings.vnet_ref].id,
    try(var.settings.virtual_network_id, null)
  )

  tags = merge(
    var.global_settings.tags,
    try(var.settings.tags, {})
  )
}
