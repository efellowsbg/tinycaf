automation_accounts = {
  test_auto_acc = {
    name                          = "automatio-account-test"
    resource_group_ref            = "rg_test"
    local_authentication_enabled  = true
    public_network_access_enabled = true

    tags = {
      Env = "Test"
    }

    encryption = {
      key_ref = "kvkey_test1"
      mi_ref  = "id_test"
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

virtual_networks = {
  vnet_test = {
    name               = "vnet-test-dv-ne-01"
    resource_group_ref = "rg_test"
    cidr               = ["10.10.10.0/24"]
    subnets = {
      snet_sqlmi = {
        name       = "snet-sql-managed-instance"
        cidr       = ["10.10.10.0/25"]
        delegation = "sql_managed_instance"
      }
      snet_private_endpoints = {
        name              = "snet-private-endpoints"
        cidr              = ["10.10.10.128/25"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
      }
    }
  }
}

managed_identities = {
  id_test = {
    name               = "id-test-dv-ne-01"
    resource_group_ref = "rg_test"
  }
}

keyvaults = {
  kv_test = {
    name               = "kv-test-dv-ne-01"
    resource_group_ref = "rg_test"
    network_rules = {
      default_action = "Deny"
      allowed_ips    = ["10.10.10.10", "20.20.20.20"]
      subnets = {
        allow_app1 = {
          subnet_ref = "vnet_test/snet_private_endpoints"
        }
      }
    }
  }
}

key_vault_keys = {
  kvkey_test1 = {
    name          = "generated-certificate"
    key_vault_ref = "kv_test"
    key_type      = "RSA"
    key_size      = "2048"

    key_opts = [
      "decrypt",
      "encrypt",
      "sign",
      "unwrapKey",
      "verify",
      "wrapKey",
    ]

    rotation_policy = {
      expire_after         = "P90D"
      notify_before_expiry = "P29D"
      automatic = {
        time_before_expiry = "P30D"
      }
    }
  }
}
