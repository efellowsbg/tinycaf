locals {
  use_storage = try(var.settings.storage_account_ref, null) != null
  use_law     = try(var.settings.log_analytics_workspace_ref, null) != null
}