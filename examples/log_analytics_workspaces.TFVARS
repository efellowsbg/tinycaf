log_analytics_workspaces = {
  log_workspace_test1 = {
    name               = "acctest-01"
    resource_group_ref = "rg_test"
    sku                = "CapacityReservation"

    identity = {
      type             = "UserAssigned"
      identity_ids_ref = ["id_test1"]
    }

    timeouts = {
      read = "6m"
    }
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
