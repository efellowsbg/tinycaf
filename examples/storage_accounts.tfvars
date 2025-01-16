storage_accounts = {
  st_test = {
    name               = "sttestdvne01"
    resource_group_ref = "rg_test"
    network_rules = {
      subnets = {
        allow_snet_app = {
          default_action = "Deny"
          bypass         = ["AzureServices", "Logging"]
          subnet_ref     = "vnet_test/snet_app"
        }
        allow_office_ip = {
          default_action = "Deny"
          allowed_ips    = ["11.12.13.14"]
        }
      }
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

virtual_networks = {
  vnet_test = {
    name               = "vnet-test-dv-ne-01"
    resource_group_ref = "rg_test"
    cidr               = ["10.0.0.0/16"]
    subnets = {
      snet_app = {
        name              = "snet-app"
        cidr              = ["10.0.0.128/25"]
        service_endpoints = ["Microsoft.Storage"]
      }
    }
  }
}
