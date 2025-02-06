locals {
  subnet_id = try(
    var.resources.virtual_networks[split("/", var.settings.subnet_ref)[0]].subnets[split("/", var.settings.subnet_ref)[1]].id,
    var.settings.subnet_ref
  )

  network_security_group_id = try(var.resources.network_security_groups[var.settings.network_security_group_ref].id, var.settings.resource_ref)

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
