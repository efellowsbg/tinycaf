output "id" {
  value = azurerm_kubernetes_cluster.main.id
}

output "current_kubernetes_version" {
  value = azurerm_kubernetes_cluster.main.current_kubernetes_version
}

output "fqdn" {
  value = azurerm_kubernetes_cluster.main.fqdn
}

output "identity" {
  value = azurerm_kubernetes_cluster.main.identity
}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.main.kubelet_identity
}
