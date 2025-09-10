locals {

  log_analytics_workspace_id = try(var.settings.log_analytics_ref, null) != null ? var.resources[try(var.settings.log_analytics_lz_key, var.client_config.landingzone_key)].log_analytics_workspaces[var.settings.log_analytics_ref].id : try(var.settings.log_analytics_workspace_id, null)

  storage_account_id = try(var.settings.storage_account_ref, null) != null ? var.resources[try(var.settings.storage_account_lz_key, var.client_config.landingzone_key)].storage_accounts[var.settings.storage_account_ref].id : try(var.settings.storage_account_id, null)


}
