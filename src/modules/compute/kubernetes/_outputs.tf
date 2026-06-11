output "id" {
  value = module.kubernetes_cluster.id
}

output "identity" {
  value = module.kubernetes_cluster.identity
}

output "kubelet_identity" {
  value = module.kubernetes_cluster.kubelet_identity
}
