log_analytics_data_export_rules = {
  rule_test1 = {
    name                   = "dataExport1"
    resource_group_ref     = "rg_test"
    workspace_resource_ref = "log_workspace_test1"
    storage_account_ref    = "st_test"
    table_names            = ["SecurityEvent"]
  }
}
