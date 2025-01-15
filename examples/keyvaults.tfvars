keyvaults = {
  kv-test = {
    name               = "kv-test-dv-ne-01"
    resource_group_ref = "rg_test"
    network = {
      default_action = "Deny"
      allowed_ips    = ["10.10.10.10", "20.20.20.20"]
      subnets = {
        subnet1 = {
          vnet_ref   = "vnet_test"
          subnet_ref = "snet_sqlmi"
        }
        subnet2 = {
          vnet_ref   = "vnet_test"
          subnet_ref = "snet_private_endpoints"
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

resource_groups = {
  rg_test = {
    name     = "rg-test-dv-ne-01"
    location = "northeurope"
  }
}
