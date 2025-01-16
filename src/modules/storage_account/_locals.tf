locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  # subnet_ids = [for config in values(var.settings.network.subnets) : var.resources.virtual_networks[config.vnet_ref].subnets[config.subnet_ref].id]
  subnet_ids = [
    for network_rule_ref, config in try(var.settings.network.subnets, {}) : (
      var.resources.virtual_networks[split("/", config.subnet_ref)[0]].subnets[split("/", config.subnet_ref)[1]].id
    )
  ]

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
