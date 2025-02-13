output "id" {
  value = azurerm_log_analytics_workspace.main.id
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.main.workspace_id
}

output "primary_shared_key" {
  value = azurerm_log_analytics_workspace.main.primary_shared_key
}

output "secondary_shared_key" {
  value = azurerm_log_analytics_workspace.main.secondary_shared_key
}
