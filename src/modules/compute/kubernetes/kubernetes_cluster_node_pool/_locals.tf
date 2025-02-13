locals {
  resource_group      = var.resources.resource_groups[var.all_settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  subnet_ids = [
    for network_rule_ref, config in try(var.settings.network_rules.subnets, {}) : (
      var.resources.virtual_networks[split("/", config.subnet_ref)[0]].subnets[split("/", config.subnet_ref)[1]].id
    )
  ]

  pod_subnet_id = try(
    var.resources.virtual_networks[split("/", var.settings.pod_subnet_ref)[0]].subnets[split("/", var.settings.pod_subnet_ref)[1]].id,
    null
  )

  vnet_subnet_id = try(
    var.resources.virtual_networks[split("/", var.settings.vnet_subnet_ref)[0]].subnets[split("/", var.settings.vnet_subnet_ref)[1]].id,
    null
  )

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
