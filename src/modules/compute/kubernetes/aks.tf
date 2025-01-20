module "kubernetes_cluster" {
  source          = "./kubernetes_cluster"
  settings        = var.settings
  global_settings = var.global_settings
  resources = var.resources
}

module "kubernetes_cluster_node_pool" {
  source          = "./kubernetes_cluster_node_pool"
  for_each = var.settings.additional_node_pools

  cluster_id = module.kubernetes_cluster.id
  all_settings = var.settings
  settings        = each.value
  global_settings = var.global_settings
  resources = var.resources
}
