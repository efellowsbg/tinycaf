resource "azurerm_kubernetes_cluster" "main" {
  name                                = var.settings.cluster_name
  resource_group_name                 = local.resource_group_name
  location                            = local.location
  tags                                = local.tags
  node_resource_group                 = try(var.settings.node_resource_group_name, null)
  sku_tier                            = try(var.settings.sku_tier, "Free")
  kubernetes_version                  = try(var.settings.kubernetes_version, null)
  dns_prefix                          = try(var.settings.dns_prefix, "default")
  private_cluster_enabled             = try(var.settings.private_cluster_enabled, false)
  private_dns_zone_id                 = try(var.settings.private_dns_zone_id, "System")
  private_cluster_public_fqdn_enabled = try(var.settings.private_cluster_public_fqdn_enabled, false)
  role_based_access_control_enabled   = try(var.settings.role_based_access_control_enabled, true)
  run_command_enabled                 = try(var.settings.run_command_enabled, true)
  oidc_issuer_enabled                 = try(var.settings.oidc_issuer_enabled, false)
  workload_identity_enabled           = try(var.settings.oidc_issuer_enabled ? var.settings.workload_identity_enabled : false, false)
  open_service_mesh_enabled           = try(var.settings.open_service_mesh_enabled, null)

  default_node_pool {
    vnet_subnet_id              = local.vnet_subnet_id
    name                        = try(var.settings.default_node_pool.name, "default")
    node_count                  = try(var.settings.default_node_pool.node_count, 1)
    vm_size                     = try(var.settings.default_node_pool.vm_size, "Standard_D2s_v3")
    type                        = try(var.settings.default_node_pool.node_type, "VirtualMachineScaleSets")
    max_pods                    = try(var.settings.default_node_pool.max_pods, null)
    zones                       = try(var.settings.default_node_pool.zones, null)
    auto_scaling_enabled        = try(var.settings.default_node_pool.node_type == "VirtualMachineScaleSets" ? var.settings.default_node_pool.node_scalling : false, false)
    min_count                   = try(var.settings.default_node_pool.node_type == "VirtualMachineScaleSets" ? var.settings.default_node_pool.min_count : null, null)
    max_count                   = try(var.settings.default_node_pool.node_type == "VirtualMachineScaleSets" ? var.settings.default_node_pool.max_count : null, null)
    os_disk_type                = try(var.settings.default_node_pool.os_disk_type, null)
    os_disk_size_gb             = try(var.settings.default_node_pool.os_disk_size_gb, null)
    os_sku                      = try(var.settings.default_node_pool.os_sku, null)
    pod_subnet_id               = try(var.settings.default_node_pool.pod_subnet_id, null)
    temporary_name_for_rotation = try(var.settings.default_node_pool.temporary_name_for_rotation, null)
    host_encryption_enabled     = try(var.settings.default_node_pool.host_encryption_enabled, false)

    dynamic "upgrade_settings" {
      for_each = try(var.settings.default_node_pool.upgrade_settings[*], {})

      content {
        drain_timeout_in_minutes      = try(upgrade_settings.value.drain_timeout_in_minutes, null)
        node_soak_duration_in_minutes = try(upgrade_settings.value.node_soak_duration_in_minutes, null)
        max_surge                     = try(upgrade_settings.value.max_surge, null)
      }
    }
  }

  network_profile {
    network_plugin      = local.effective_network_profile.network_plugin
    network_mode        = local.effective_network_profile.network_mode
    network_policy      = local.effective_network_profile.network_policy
    load_balancer_sku   = local.effective_network_profile.load_balancer_sku
    network_data_plane  = local.validated_network_data_plane
    network_plugin_mode = local.effective_network_profile.network_plugin_mode
    outbound_type       = local.effective_network_profile.outbound_type
    dns_service_ip      = local.effective_network_profile.dns_service_ip
    service_cidr        = local.effective_network_profile.service_cidr
    service_cidrs       = local.effective_network_profile.service_cidrs
    pod_cidr            = local.validated_pod_cidr
  }
  node_os_upgrade_channel      = try(var.settings.node_os_upgrade_channel, null)
  image_cleaner_interval_hours = try(var.settings.image_cleaner_interval_hours, null)
  local_account_disabled       = try(var.settings.local_account_disabled, null)
  identity {
    type         = try(var.settings.identity.type, "SystemAssigned")
    identity_ids = try(var.settings.identity.type == "UserAssigned" ? [local.managed_identity.id] : null, null)
  }

  dynamic "storage_profile" {
    for_each = try(var.settings.storage_profile[*], {})

    content {
      blob_driver_enabled         = try(storage_profile.value.blob_driver_enabled, false)
      disk_driver_enabled         = try(storage_profile.value.disk_driver_enabled, true)
      file_driver_enabled         = try(storage_profile.value.file_driver_enabled, true)
      snapshot_controller_enabled = try(storage_profile.value.snapshot_controller_enabled, true)
    }
  }

  dynamic "api_server_access_profile" {
    for_each = try(var.settings.api_server_access_profile[*], {})
    content {
      authorized_ip_ranges = try(api_server_access_profile.value.authorized_ip_ranges, null)
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = try(var.settings.azure_active_directory_role_based_access_control[*], {})
    content {
      tenant_id              = try(var.global_settings.tenant_id, null)
      admin_group_object_ids = try(azure_active_directory_role_based_access_control.value.admin_group_object_ids, null)
      azure_rbac_enabled     = try(azure_active_directory_role_based_access_control.value.azure_rbac_enabled, true)
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = try(var.settings.key_vault_secrets_provider[*], {})
    content {
      secret_rotation_enabled  = try(key_vault_secrets_provider.value.secret_rotation_enabled, null)
      secret_rotation_interval = try(key_vault_secrets_provider.value.secret_rotation_interval, null)
    }
  }

  dynamic "kubelet_identity" {
    for_each = try(var.settings.kubelet_identity[*], {})
    content {
      client_id                 = try(kubelet_identity.value.type == "UserAssigned" ? local.kubelet_identity.client_id : null, null)
      object_id                 = try(kubelet_identity.value.type == "UserAssigned" ? local.kubelet_identity.principal_id : null, null)
      user_assigned_identity_id = try(kubelet_identity.value.type == "UserAssigned" ? local.kubelet_identity.id : null, null)
    }
  }
  dynamic "upgrade_override" {
    for_each = can(var.settings.upgrade_override) ? [1] : []
    content {
      force_upgrade_enabled = try(var.settings.upgrade_override.force_upgrade_enabled, false)
      effective_until       = try(var.settings.upgrade_override.effective_until, null)
    }
  }
  dynamic "linux_profile" {
    for_each = try(var.settings.linux_profile, null) == null ? [] : [1]
    content {
      admin_username = try(var.settings.linux_profile.admin_username, null)
      ssh_key {
        key_data = try(var.settings.linux_profile.ssh_key_data, null)
      }
    }
  }


}
