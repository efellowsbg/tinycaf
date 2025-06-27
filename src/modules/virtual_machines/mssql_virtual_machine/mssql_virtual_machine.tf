resource "azurerm_mssql_virtual_machine" "main" {
  virtual_machine_id = local.virtual_machine_id
  sql_license_type   = try(var.settings.sql_license_type, "PAYG")
  dynamic "auto_backup" {
    for_each = can(var.settings.auto_backup) ? [1] : []
    content {
      retention_period_in_days   = try(var.settings.auto_backup.retention_period_in_days, null)
      storage_account_access_key = try(var.settings.auto_backup.storage_account_access_key, null)
      storage_blob_endpoint      = try(var.settings.auto_backup.storage_blob_endpoint, null)
    }
  }
  sql_connectivity_port = try(var.settings.sql_connectivity_port, 1433)
  sql_connectivity_type = try(var.settings.sql_connectivity_type, "PRIVATE")
  r_services_enabled    = try(var.settings.r_services_enabled, false)
  tags                  = local.tags
}
