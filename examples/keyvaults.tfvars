keyvaults = {
  kv-test = {
    name                          = "kv-test-dev-01"
    resource_group_ref            = "rg-test"
    public_network_access_enabled = true
    network_rules = {
      default_action = "Allow"
      allowed_ips    = ["10.10.10.10"]
      subnets = {
        subnet1 = {
          subnet_ref = "vnet_test/snet_private_endpoints"
        }
      }
    }
    access_policies = {
      managed_identity = {
        managed_identity_refs = ["id_test"]
        secret_permissions    = "All"
        key_permissions       = ["Get", "List"]
      }
      logged_in_user = {
        secret_permissions = "All"
        key_permissions    = "All"
      }
      object_ids = {
        object_ids         = ["xxxxxxxxxxx-xxxxxxxxxxxxxxx"]
        secret_permissions = "All"
        key_permissions    = "All"
      }
    }
    secrets = {
      secret-skey = {
        name           = "SecretKey"
        value          = "default"
        ignore_changes = true
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

managed_identities = {
  id_test = {
    name   = "id-test-dv-ne-01"
    rg_ref = "rg_test"
  }
}
