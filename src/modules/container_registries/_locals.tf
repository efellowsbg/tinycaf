locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  subnet_id = var.resources.virtual_networks[
    split("/", var.settings.private_endpoint.subnet_ref)[0]
    ].subnets[
    split("/", var.settings.private_endpoint.subnet_ref)[1]
  ].id

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
