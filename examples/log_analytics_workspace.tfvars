log_analytics_workspaces = {
  log_workspace_test1 = {
    name               = "law-test-01"
    resource_group_ref = "rg_test"

    identity = {
      type             = "UserAssigned"
      identity_ids_ref = ["id_test1"]
    }

    timeouts = {
      read = "6m"
    }

    # This is example is if rule is created from inside this module
    # rules = {
    #   rule_test1 = {
    #     name                = "dataExport1"
    #     storage_account_ref = "st_test"
    #     table_names         = ["Heartbeat"]
    #     enabled             = true
    #   }
    # }
  }
}

# pre-requisites
resource_groups = {
  rg_test = {
    name     = "rg-test-dv-ne-01"
    location = "northeurope"
  }
}

managed_identities = {
  id_test1 = {
    name               = "id-test-dv-ne-01"
    resource_group_ref = "rg_test"
  }
}
