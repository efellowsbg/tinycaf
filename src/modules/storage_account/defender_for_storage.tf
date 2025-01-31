resource "azurerm_security_center_storage_defender" "dp" {
  count = can(var.settings.defender_storage_plan) ? 1 : 0

  storage_account_id                          = azurerm_storage_account.main.id
  override_subscription_settings_enabled      = try(var.settings.defender_storage_plan.override_subscription_settings_enabled, null)
  malware_scanning_on_upload_enabled          = try(var.settings.defender_storage_plan.malware_scanning_on_upload_enabled, null)
  malware_scanning_on_upload_cap_gb_per_month = try(var.settings.defender_storage_plan.malware_scanning_on_upload_cap_gb_per_month, null)
  sensitive_data_discovery_enabled            = try(var.settings.defender_storage_plan.sensitive_data_discovery_enabled, null)
}
