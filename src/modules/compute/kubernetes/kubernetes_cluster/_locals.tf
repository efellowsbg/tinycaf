locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  managed_identity = can(
    var.resources[
      try(var.settings.identity.lz_key, var.client_config.landingzone_key)
    ].managed_identities[var.settings.identity.managed_identity_ref]
    ) ? var.resources[
    try(var.settings.identity.lz_key, var.client_config.landingzone_key)
  ].managed_identities[var.settings.identity.managed_identity_ref] : null

  kubelet_identity = can(
    var.resources[
      try(var.settings.kubelet_identity.lz_key, var.client_config.landingzone_key)
    ].managed_identities[var.settings.kubelet_identity.managed_identity_ref]
    ) ? var.resources[
    try(var.settings.kubelet_identity.lz_key, var.client_config.landingzone_key)
  ].managed_identities[var.settings.kubelet_identity.managed_identity_ref] : null

  validated_pod_cidr           = local.effective_network_profile.network_plugin == "azure" && local.effective_network_profile.pod_cidr != null && local.effective_network_profile.network_plugin_mode != "overlay" ? error("Error: When network_plugin is 'azure', pod_cidr must not be set unless network_plugin_mode is 'overlay'.") : local.effective_network_profile.pod_cidr
  validated_network_data_plane = local.effective_network_profile.network_policy == "cilium" && local.effective_network_profile.network_data_plane != "cilium" ? error("Error: When network_policy is set to 'cilium', the network_data_plane must also be set to 'cilium'.") : local.effective_network_profile.network_data_plane

  subnet_ids = [
    for network_rule_ref, config in try(var.settings.network_rules.subnets, {}) : (
      var.resources[
        try(config.lz_key, var.client_config.landingzone_key)
        ].virtual_networks[
        split("/", config.subnet_ref)[0]
        ].subnets[
        split("/", config.subnet_ref)[1]
      ].id
    )
  ]


  vnet_subnet_id = try(
    var.resources[
      try(var.settings.default_node_pool.lz_key, var.client_config.landingzone_key)
      ].virtual_networks[
      split("/", var.settings.default_node_pool.subnet_ref)[0]
      ].subnets[
      split("/", var.settings.default_node_pool.subnet_ref)[1]
    ].id,
    null
  )

  effective_network_profile = {
    network_plugin      = try(var.settings.network_profile.network_plugin, "azure")
    network_mode        = try(var.settings.network_profile.network_mode, null)
    network_policy      = try(var.settings.network_profile.network_policy, "calico")
    load_balancer_sku   = try(var.settings.network_profile.load_balancer_sku, "standard")
    network_data_plane  = try(var.settings.network_profile.network_data_plane, "azure")
    network_plugin_mode = try(var.settings.network_profile.network_plugin_mode, null)
    outbound_type       = try(var.settings.network_profile.outbound_type, "loadBalancer")
    dns_service_ip      = try(var.settings.network_profile.dns_service_ip, null)
    service_cidr        = try(var.settings.network_profile.service_cidr, null)
    service_cidrs       = try(var.settings.network_profile.service_cidrs, null)
    pod_cidr            = try(var.settings.network_profile.pod_cidr, null)
  }

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
