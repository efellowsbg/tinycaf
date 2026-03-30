automation_accounts = {
  test_auto_acc = {
    name                          = "automation-account-test"
    resource_group_ref            = "rg_test"
    sku_name                      = "Basic"
    local_authentication_enabled  = true
    public_network_access_enabled = true

    identity = {
      type = "SystemAssigned"
    }

    python_packages = {
      requests = {
        version     = "2.32.3"
        content_uri = "https://files.pythonhosted.org/packages/source/r/requests/requests-2.32.3.tar.gz"
      }
    }

    tags = {
      Env = "Test"
    }
  }
}

# pre-requisites
resource_groups = {
  rg_test = {
    name     = "rg-test-01"
    location = "northeurope"
    tags = {
      DeployDate = "11/07/2025",
      DeadLine   = "11/07/2026",
      Owner      = "Test Test",
      Project    = "Test",
    }
  }
}
