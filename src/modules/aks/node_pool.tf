resource "azurerm_kubernetes_cluster_node_pool" "node_pools" {
  for_each = { for pool in var.settings.additional_node_pools : pool.name => pool }

  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  auto_scaling_enabled  = each.value.enable_auto_scaling
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  max_pods              = each.value.max_pods
  zones                 = each.value.availability_zones
  node_labels           = each.value.node_labels
  node_taints           = each.value.node_taints
  tags                  = each.value.tags
}
