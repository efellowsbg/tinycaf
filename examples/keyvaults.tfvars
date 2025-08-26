keyvaults = {
  kv_test = {
    name               = "kv-test-dv-ne-01"
    resource_group_ref = "rg_test"
    access_policies = {
      access_policy_01 = {
        secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
        key_permissions         = ["Get", "List", "Update", "Create", "Import", "Decrypt", "Delete", "Encrypt", "Recover", "Backup", "Restore", "Purge", "Sign", "UnwrapKey", "Verify", "WrapKey"]
        certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Recover", "Restore", "SetIssuers", "Update", "Purge"]
        object_ids              = ["00000000-0000-0000-0000-000000000000"]
        user_principal_names    = ["user.one@test.com", "user.two@test.com"]
      }
    }
    network_rules = {
      default_action = "Deny"
      allowed_ips    = ["10.10.10.10", "20.20.20.20"]
      subnets = {
        allow_app1 = {
          subnet_ref = "vnet_test/snet_app1"
        }
        allow_private_endpoints = {
          subnet_ref = "vnet_test/snet_private_endpoints"
        }
      }
    }
  }
}

# pre-requisites
virtual_networks = {
  vnet_test = {
    name               = "vnet-test-dv-ne-01"
    resource_group_ref = "rg_test"
    cidr               = ["10.10.10.0/24"]
    subnets = {
      snet_sqlmi = {
        name = "snet-app1"
        cidr = ["10.10.10.0/25"]
      }
      snet_private_endpoints = {
        name              = "snet-private-endpoints"
        cidr              = ["10.10.10.128/25"]
        service_endpoints = ["Microsoft.KeyVault"]
      }
    }
  }
}

resource_groups = {
  rg_test = {
    name     = "rg-test-dv-ne-01"
    location = "northeurope"
  }
}
