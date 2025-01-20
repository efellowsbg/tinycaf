resource "azurerm_kubernetes_cluster_node_pool" "main" {
  name                  = var.settings.name
  kubernetes_cluster_id = var.cluster_id
  vm_size               = try(var.settings.vm_size, "Standard_DS2_v2")
  node_count            = try( var.settings.node_count, 1 )
  auto_scaling_enabled  = try(var.settings.auto_scaling_enabled,null)
  min_count             = try(var.settings.min_count,null)
  max_count             = try(var.settings.max_count,null)
  max_pods              = try(var.settings.max_pods,null)
  zones                 = try(var.settings.zones,null)
  node_labels           = try(var.settings.node_labels,null)
  node_taints           = try(var.settings.node_taints,null)
  tags                  = local.tags
}