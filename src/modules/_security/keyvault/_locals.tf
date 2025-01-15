locals {
  resource_group = var.resources.resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
  tenant_id = var.tenant_id
  subnet_ids = (
    try(var.settings.network.subnets, null) == null ? null : [
      for _, value in var.settings.network.subnets : (
        can(value.subnet_id) ? value.subnet_id : var.resources.virtual_networks[value.vnet_ref].subnets[value.subnet_ref].id
      )
    ]
  )
}
