output "diagnostic_setting_id" {
  value       = azurerm_monitor_diagnostic_setting.main.id
  description = "The ID of the diagnostic setting."
}
