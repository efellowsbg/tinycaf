resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.settings.cluster_name
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location
  node_resource_group = local.node_resource_group.name
  sku_tier            = try(var.settings.sku_tier, "Free")
  kubernetes_version  = try(var.settings.kubernetes_version, null)

  default_node_pool {
    name                 = try(var.settings.def_node_name, "default")
    node_count           = try(var.settings.def_node_count, 1)
    vm_size              = try(var.settings.def_node_vm_size, "Standard_D2s_v3")
    type                 = try(var.settings.def_node_type, "VirtualMachineScaleSets")
    max_pods             = try(var.settings.def_node_max_pods, null)
    zones                = try(var.settings.def_node_zones, null)
    auto_scaling_enabled = try(var.settings.def_node_type == "VirtualMachineScaleSets" ? var.settings.def_node_scalling : false, false)
    min_count            = try(var.settings.def_node_type == "VirtualMachineScaleSets" ? var.settings.def_node_min_count : null, null)
    max_count            = try(var.settings.def_node_type == "VirtualMachineScaleSets" ? var.settings.def_node_max_count : null, null)
    vnet_subnet_id       = local.vnet_id
  }

  network_profile {
    network_plugin    = try(var.settings.network_profile.network_plugin, "azure")
    network_mode      = try(var.settings.network_profile.network_mode, "bridge")
    network_policy    = try(var.settings.network_profile.network_policy, "calico")
    load_balancer_sku = try(var.settings.network_profile.load_balancer_sku, "standard")

    network_data_plane  = local.validated_network_data_plane
    network_plugin_mode = try(var.settings.network_profile.network_plugin_mode, "overlay")
    outbound_type       = try(var.settings.network_profile.outbound_type, "loadBalancer") # "loadBalancer", "userDefinedRouting", "managedNATGateway", "userAssignedNATGateway"

    dns_service_ip = try(var.settings.network_profile.dns_service_ip, null) # E.g., "10.0.0.10"
    service_cidr   = try(var.settings.network_profile.service_cidr, null)   # E.g., "10.0.0.0/16"
    service_cidrs  = try(var.settings.network_profile.service_cidrs, null)  # For dual-stack networking, e.g., ["10.0.0.0/16", "fd02::/112"]

    pod_cidr = local.validated_pod_cidr

  }

  private_cluster_enabled             = try(var.settings.private_cluster_enabled, false)
  private_dns_zone_id                 = try(var.settings.private_dns_zone_id, "System")
  private_cluster_public_fqdn_enabled = try(var.settings.private_cluster_public_fqdn_enabled, false)
  api_server_access_profile {
    authorized_ip_ranges = try(var.settings.authorized_ip_ranges, null)
  }
  role_based_access_control_enabled = try(var.settings.role_based_access_control_enabled, true)
  azure_active_directory_role_based_access_control {
    tenant_id              = var.global_settings.tenant_id
    admin_group_object_ids = try(var.settings.admin_group_object_ids, null)
    azure_rbac_enabled     = try(var.settings.azure_rbac_enabled, true)
  }
  run_command_enabled = try(var.settings.run_command_enabled, true)

  identity {
    type         = try(var.settings.identity, "SystemAssigned")
    identity_ids = try(var.settings.identity == "UserAssigned" ? local.managed_identity.id : null, null)
  }
  kubelet_identity {
    client_id                 = try(var.settings.identity == "UserAssigned" ? local.managed_identity.client_id : null, null)
    object_id                 = try(var.settings.identity == "UserAssigned" ? local.managed_identity.principal_id : null, null)
    user_assigned_identity_id = try(var.settings.identity == "UserAssigned" ? local.managed_identity.id : null, null)
  }

  oidc_issuer_enabled       = try(var.settings.oidc_issuer_enabled, false)
  workload_identity_enabled = try(var.settings.oidc_issuer_enabled ? var.settings.workload_identity_enabled_ref : false, false)
  open_service_mesh_enabled = try(var.settings.open_service_mesh_enabled, false)

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
