locals {
  resource_group = var.resources.resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )

  public_ip_address_id = (
    can(ip_configuration.value.public_ip_address_id) || !can(ip_configuration.value.public_ip_address_key)
  ) ? try(ip_configuration.value.public_ip_address_id, null) : var.resources.public_ips[ip_configuration.value.public_ip_address_ref].id

  subnet_id = can(ip_configuration.value.subnet_id) ? ip_configuration.value.subnet_id : var.resources.virtual_networks[ip_configuration.value.vnet_ref].subnets[ip_configuration.value.subnet_ref].id
}
