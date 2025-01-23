locals {
  resource_group = var.resources.resource_groups[var.all_settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  subnet_ids = [
    for network_rule_ref, config in try(var.settings.network_rules.subnets, {}) : (
      var.resources.virtual_networks[split("/", config.subnet_ref)[0]].subnets[split("/", config.subnet_ref)[1]].id
    )
  ]
  vnet_subnet_id = try(
    var.resources.virtual_networks[split("/", var.all_settings.subnet_ref)[0]].subnets[split("/", var.all_settings.subnet_ref)[1]].id,
    null
  )
  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
