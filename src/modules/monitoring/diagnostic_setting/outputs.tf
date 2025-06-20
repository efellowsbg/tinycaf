output "diagnostic_setting_ids" {
  description = "Map of all diagnostic setting resource IDs"
  value = {
    for key, setting in azurerm_monitor_diagnostic_setting.main :
    key => setting.id
  }
}
