locals {
  resource_group = var.resources.resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}

locals {
  vnet                 = var.resources.virtual_networks[var.settings.ip_configuration.each.value.vnet_ref]
  subnet_id            = can(each.value.subnet_id) ? each.value.subnet_id : local.vnet.subnets[subnet_ref].id
  public_ip_address_id = can(each.value.public_ip_address_id) ? each.value.public_ip_address_id : var.resources.public_ips[var.settings.ip_configuration.each.value.public_ip_ref].id
}
