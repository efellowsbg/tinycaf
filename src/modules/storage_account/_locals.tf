locals {
  resource_group = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location = local.resource_group.location

  vnet = var.resources.virtual_networks.vnet_ref
  subnet_id = local.vnet[var.settings.network.subnet_ref]

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    lookup(var.settings, "tags", {})
  )
}