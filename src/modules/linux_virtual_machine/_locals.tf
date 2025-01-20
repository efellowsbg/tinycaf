locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  network_interface_ids = [for nics_ref, config in var.settings.network_interface_ids : config.nic_ref]

  # subnet_id = var.resources.virtual_networks[
  #   split("/", var.settings.network_interfaces.ip_configuration.subnet_ref)[0]
  #   ].subnets[
  #   split("/", var.settings.network_interfaces.ip_configuration.subnet_ref)[1]
  # ].id

  subnet_id = {
    for nic, config in var.settings.network_interfaces :
    nic => var.resources.virtual_networks[
      split("/", config.ip_configuration.subnet_ref)[0]
      ].subnets[
      split("/", config.ip_configuration.subnet_ref)[1]
    ].id
  }

  public_key = tls_private_key.main[var.settings.admin_ssh_key.public_key_ref]
  # .public_key_openssh

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
