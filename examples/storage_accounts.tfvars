storage_accounts = {
  st_test = {
    name                     = "sttestdvne01"
    resource_group_ref       = "rg_test"
    account_replication_type = "LRS"
    network_rules = {
      default_action = "Allow"
      allowed_ips    = ["10.10.10.10"]
      bypass         = ["AzureServices", "Logging"]
      subnets = {
        subnet_config_1 = {
          subnet_ref = "vnet_test/snet_app"
        }
      }
    }
    containers = {
      container_test_1 = {
        name                  = "vhds1"
        container_access_type = "private"
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
