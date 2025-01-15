locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  # vnet = var.resources.virtual_networks[var.settings.network.config.vnet_ref]
  # subnet_id = local.vnet.subnets[var.settings.network.subnet_ref].id

  # subnet_id = [for config in values(local.storage_account_network) : local.virtual_networks[config.vnet_ref].subnets[config.subnet_ref].id]
  subnet_ids = (
    try(var.settings.network, null) == null ? null : [
      for _, value in var.settings.network : (
        can(value.subnet_id) ? value.subnet_id : var.resources.virtual_networks[value.vnet_ref].subnets[value.subnet_ref].id
      )
    ]
  )

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
