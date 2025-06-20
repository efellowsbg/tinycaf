resource "azurerm_monitor_diagnostic_setting" "main" {
  name               = var.diagnostic_name
  target_resource_id = var.target_resource_id

  dynamic "log" {
    for_each = var.logs
    content {
      category = log.value.category
      enabled  = log.value.enabled

    }
  }

  dynamic "metric" {
    for_each = var.metrics
    content {
      category = metric.value.category
      enabled  = metric.value.enabled

    }
  }

  dynamic "log_analytics_workspace_id" {
    for_each = var.log_analytics_workspace_id != null ? [1] : []
    content {
      workspace_id = var.log_analytics_workspace_id
    }
  }

  dynamic "storage_account_id" {
    for_each = var.storage_account_id != null ? [1] : []
    content {
      storage_account_id = var.storage_account_id
    }
  }
}







### tfvars example (Test 1 - Key Vault to Storage Account)

# test-keyvault-to-storage.tfvars

target_resource_id     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-demo/providers/Microsoft.KeyVault/vaults/my-keyvault"

diagnostic_name = "kv-diag"

storage_account_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-demo/providers/Microsoft.Storage/storageAccounts/privatekvlogs"

log_analytics_workspace_id = null

logs = [
  {
    category = "AuditEvent"
    enabled  = true
  }
]

metrics = []
