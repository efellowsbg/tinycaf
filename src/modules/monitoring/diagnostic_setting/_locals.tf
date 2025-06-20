locals {
  use_storage = var.storage_account_id != null
  use_law     = var.log_analytics_workspace_id != null
} 