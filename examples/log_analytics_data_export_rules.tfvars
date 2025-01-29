log_analytics_data_export_rules = {
  rule_test1 = {
    name                   = "dataExport1"
    resource_group_ref     = "rg_test"
    workspace_resource_ref = "log_workspace_test1"
    storage_account_ref    = "st_test"
    table_names            = ["SecurityEvent"]
  }
}

# pre-requisites
resource_groups = {
  rg_test = {
    name     = "rg-test-dv-ne-01"
    location = "northeurope"
  }
}

storage_accounts = {
  st_test = {
    name                     = "sttestdvne01"
    resource_group_ref       = "rg_test"
    account_replication_type = "LRS"

    containers = {
      container_test_1 = {
        name                  = "logs-container-test1"
        container_access_type = "private"
      }
    }
  }
}

log_analytics_workspaces = {
  log_workspace_test1 = {
    name               = "acctest-01"
    resource_group_ref = "rg_test"
  }
}
