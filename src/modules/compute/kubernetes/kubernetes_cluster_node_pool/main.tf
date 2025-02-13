resource "azurerm_kubernetes_cluster_node_pool" "main" {
  name                  = var.settings.name
  kubernetes_cluster_id = var.cluster_id
  tags                  = local.tags

  vm_size                 = try(var.settings.vm_size, "Standard_DS2_v2")
  node_count              = try(var.settings.node_count, 1)
  auto_scaling_enabled    = try(var.settings.auto_scaling_enabled, false)
  min_count               = try(var.settings.min_count, null)
  max_count               = try(var.settings.max_count, null)
  max_pods                = try(var.settings.max_pods, null)
  zones                   = try(var.settings.zones, null)
  node_labels             = try(var.settings.node_labels, null)
  node_taints             = try(var.settings.node_taints, null)
  os_disk_type            = try(var.settings.os_disk_type, null)
  os_disk_size_gb         = try(var.settings.os_disk_size_gb, null)
  os_sku                  = try(var.settings.os_sku, "Ubuntu")
  pod_subnet_id           = try(var.settings.pod_subnet_id, null)
  vnet_subnet_id          = try(local.vnet_subnet_id, null)
  os_type                 = try(var.settings.os_type, null)
  ultra_ssd_enabled       = try(var.settings.ultra_ssd_enabled, false)
  fips_enabled            = try(var.settings.fips_enabled, false)
  host_encryption_enabled = try(var.settings.host_encryption_enabled, false)
  kubelet_disk_type       = try(var.settings.kubelet_disk_type, "OS")
  node_public_ip_enabled  = try(var.settings.node_public_ip_enabled, false)
  orchestrator_version    = try(var.settings.orchestrator_version, null)
}
