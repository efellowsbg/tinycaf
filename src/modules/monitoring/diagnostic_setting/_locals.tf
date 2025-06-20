locals {
  use_storage = try(var.diagnostic_setting.storage_account_ref, null) != null
  use_law     = try(var.diagnostic_setting.log_analytics_workspace_ref, null) != null
}
