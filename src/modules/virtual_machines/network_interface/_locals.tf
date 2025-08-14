locals {
  # keep your existing locals
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )

  nic_ip_configs = {
    for nic_key, nic in var.settings.network_interfaces :
    nic_key => (
      try(nic.ip_configurations, null) != null
      ? nic.ip_configurations
      : (
        try(nic.ip_configuration, null) != null
        ? {
          (lookup(nic.ip_configuration, "name", "ipconfig-primary")) = merge(nic.ip_configuration, { primary = true })
        }
        : {}
      )
    )
  }
}
