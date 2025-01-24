resource "azurerm_kubernetes_cluster" "main" {
  name                = var.settings.cluster_name
  resource_group_name = local.resource_group_name
  location            = local.location
  node_resource_group = local.node_resource_group_name
  sku_tier            = try(var.settings.sku_tier, "Free")
  kubernetes_version  = try(var.settings.kubernetes_version, null)
  dns_prefix          = try(var.settings.dns_prefix, "default")

  default_node_pool {
    name                 = try(var.settings.default_node_pool.name, "default")
    node_count           = try(var.settings.default_node_pool.node_count, 1)
    vm_size              = try(var.settings.default_node_pool.vm_size, "Standard_D2s_v3")
    type                 = try(var.settings.default_node_pool.node_type, "VirtualMachineScaleSets")
    max_pods             = try(var.settings.default_node_pool.max_pods, null)
    zones                = try(var.settings.default_node_pool.node_zones, null)
    auto_scaling_enabled = try(var.settings.default_node_pool.node_type == "VirtualMachineScaleSets" ? var.settings.default_node_pool.node_scalling : false, false)
    min_count            = try(var.settings.default_node_pool.node_type == "VirtualMachineScaleSets" ? var.settings.default_node_pool.min_count : null, null)
    max_count            = try(var.settings.default_node_pool.node_type == "VirtualMachineScaleSets" ? var.settings.default_node_pool.max_count : null, null)
    os_disk_type = try(var.settings.default_node_pool.os_disk_type, null)
    os_disk_size_gb = try(var.settings.default_node_pool.os_disk_size_gb, null)
    os_sku = try(var.settings.default_node_pool.os_sku, null)
    vnet_subnet_id       = local.vnet_subnet_id
    pod_subnet_id = local.vnet_subnet_id
    temporary_name_for_rotation = try(var.settings.default_node_pool.temporary_name_for_rotation, null)
  }

  network_profile {
    network_plugin      = local.effective_network_profile.network_plugin
    network_mode        = local.effective_network_profile.network_mode
    network_policy      = local.effective_network_profile.network_policy
    load_balancer_sku   = local.effective_network_profile.load_balancer_sku
    network_data_plane = local.validated_network_data_plane
    network_plugin_mode = local.effective_network_profile.network_plugin_mode
    outbound_type       = local.effective_network_profile.outbound_type
    dns_service_ip      = local.effective_network_profile.dns_service_ip
    service_cidr        = local.effective_network_profile.service_cidr
    service_cidrs       = local.effective_network_profile.service_cidrs
    pod_cidr            = local.validated_pod_cidr
  }

  storage_profile {
    blob_driver_enabled      = try(var.settings.storage_profile.blob_driver_enabled,false)
    disk_driver_enabled        = try(var.settings.storage_profile.disk_driver_enabled,true)
    file_driver_enabled      = try(var.settings.storage_profile.file_driver_enabled,true)
    snapshot_controller_enabled   = try(var.settings.storage_profile.snapshot_controller_enabled,true)
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
  dynamic "key_vault_secrets_provider" {
    for_each = try(var.settings.key_vault_secrets_provider, null) == null ? [] : [1]
    content {
      secret_rotation_enabled  = try(key_vault_secrets_provider.value.secret_rotation_enabled, null)
      secret_rotation_interval = try(key_vault_secrets_provider.value.secret_rotation_interval, null)
    }
  }
  identity {
    type         = try(var.settings.identity.type, "SystemAssigned")
    identity_ids = try(var.settings.identity.type == "UserAssigned" ? [local.managed_identity.id] : null, null)
  }
  kubelet_identity {
    client_id                 = try(var.settings.kubelet_identity.type == "UserAssigned" ? local.kubelet_identity.client_id : null, null)
    object_id                 = try(var.settings.kubelet_identity.type == "UserAssigned" ? local.kubelet_identity.principal_id : null, null)
    user_assigned_identity_id = try(var.settings.kubelet_identity.type == "UserAssigned" ? local.kubelet_identity.id : null, null)
  }

  oidc_issuer_enabled       = try(var.settings.oidc_issuer_enabled, false)
  workload_identity_enabled = try(var.settings.oidc_issuer_enabled ? var.settings.workload_identity_enabled: false, false)
  open_service_mesh_enabled = try(var.settings.open_service_mesh_enabled, false)

  tags = local.tags
}
