keyvaults = {
  kv_test = {
    name               = "kv-test-dv-ne-01"
    resource_group_ref = "rg_test"
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
        name       = "snet-app1"
        cidr       = ["10.10.10.0/25"]
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
