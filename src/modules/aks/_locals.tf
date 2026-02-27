locals {

  # Validate network_policy and network_data_plane compatibility
  validated_network_data_plane = var.settings.network_profile.network_policy == "cilium" && var.settings.network_profile.network_data_plane != "cilium" ? (throw("Error: When network_policy is set to 'cilium', the network_data_plane must also be set to 'cilium'.")) : var.settings.network_profile.network_data_plane

  # Validate pod_cidr compatibility
  validated_pod_cidr = var.settings.network_profile.network_plugin == "azure" && var.settings.network_profile.pod_cidr != null && var.settings.network_profile.network_plugin_mode != "overlay" ? (throw("Error: When network_plugin is 'azure', pod_cidr must not be set unless network_plugin_mode is 'overlay'.")) : var.settings.network_profile.pod_cidr

  #network_plugin_mode

  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  node_resource_group = var.resources.resource_groups[var.settings.node_resource_group_ref]
  managed_identity    = can(var.resources.managed_identities[var.settings.managed_identity_ref]) ? var.resources.managed_identities[var.settings.managed_identity_ref] : null

  vnet_id = try(var.resources.virtual_networks[var.settings.subnet_ref].id, null)

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )

}