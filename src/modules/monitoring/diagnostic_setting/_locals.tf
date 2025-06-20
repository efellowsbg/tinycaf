locals {
  use_storage = try(var.diagnostic_settings.storage_account_ref, null) != null
  use_law     = try(var.diagnostic_settings.log_analytics_workspace_ref, null) != null
}
