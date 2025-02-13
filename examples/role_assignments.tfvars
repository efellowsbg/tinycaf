role_assignments = {
  custom_roles = {
    storage_accounts = {
      "test_role1" = {
        st_test = {
          managed_identities = ["id_test1"]
        }
      }
      "test_role2" = {
        st_test = {
          managed_identities = ["id_test2"]
        }
      }
    }

    resource_groups = {
      "test_role3" = {
        rg_test = {
          managed_identities = ["id_test3"]
        }
      }
    }

    virtual_networks = {
      "test_role3" = {
        vnet_test = {
          object_ids = ["d5efa5c3-8d04-4ac3-a1ba-8fd2c0b70809"]
        }
      }
    }
  }

  built_in_roles = {
    resource_groups = {
      "Disk Pool Operator" = {
        rg_test2 = {
          managed_identities = ["id_test3"]
        }
      }
    }

    virtual_networks = {
      "Contributor" = {
        vnet_test = {
          object_ids = ["d5efa5c3-8d04-4ac3-a1ba-8fd2c0b70809"]
        }
      }
    }
  }
}

# pre-requisites
resource_groups = {
  rg_test = {
    name     = "rg-ilchevdef-02"
    location = "northeurope"
    tags = {
    }
  }

  rg_test2 = {
    name     = "rg-raynovdev-03"
    location = "northeurope"
    tags = {
    }
  }
}

role_definitions = {
  test_role1 = {
    name = "test-role1"

    permissions = {
      actions     = ["Microsoft.Insights/alertRules/*", ]
      not_actions = []
    }
  }

  test_role2 = {
    name = "test-role2"

    permissions = {
      actions     = ["*"]
      not_actions = ["Microsoft.Insights/alertRules/*", ]
    }
  }

  test_role3 = {
    name = "test-role3"

    permissions = {
      actions     = ["*"]
      not_actions = ["Microsoft.Insights/*", ]
    }
  }
}

storage_accounts = {
  st_test = {
    name                     = "sttacilchevcx02"
    resource_group_ref       = "rg_test"
    account_replication_type = "LRS"
  }
}

virtual_networks = {
  vnet_test = {
    name               = "vnet-test-dv-ne-01"
    resource_group_ref = "rg_test"
    cidr               = ["10.10.10.0/24"]
    subnets = {
      snet_app = {
        name              = "snet-private-endpoints"
        cidr              = ["10.10.10.128/25"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
      }
    }
  }
}

managed_identities = {
  id_test1 = {
    name               = "id-test-dv-ne-01"
    resource_group_ref = "rg_test"
  }

  id_test2 = {
    name               = "id-test-dv-ne-02"
    resource_group_ref = "rg_test"
  }

  id_test3 = {
    name               = "id-test-dv-ne-03"
    resource_group_ref = "rg_test"
  }
}
