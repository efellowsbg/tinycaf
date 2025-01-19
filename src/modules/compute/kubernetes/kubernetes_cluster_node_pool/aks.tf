resource "azurerm_kubernetes_cluster_node_pool" "example" {
  name                  = try(var.settings.name)
  kubernetes_cluster_id = var.cluster_id
  vm_size               = try(var.settings.vm_size, "Standard_DS2_v2")
  node_count            = try( var.settings.node_count, 1 )
  max_pods = try(var.settings.max_pods, 120)
  vnet_subnet_id = local.vnet_subnet_id
  tags = local.tags
}
