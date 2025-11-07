private_dns_cname_records = {
  test_cname_record = {
    name               = "myservice"
    resource_group_ref = "rg_test"
    zone_ref           = "test_dns_zone"
    record             = "myservice.azurewebsites.net"
    tags = {
      environment = "test"
    }
  }
}

# pre-requisites
resource_groups = {
  rg_test = {
    name     = "rg-bray-01"
    location = "northeurope"
    tags = {
      DeployDate = "11/07/2025",
      DeadLine   = "11/07/2026",
      Owner      = "Borislav Raynov",
      Project    = "Test",
    }
  }
}

private_dns_zones = {
  test_dns_zone = {
    name               = "testzone.local"
    resource_group_ref = "rg_test"
    vnet_ref           = ["vnet_test", "vnet_test2"]
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
  vnet_test2 = {
    name               = "vnet-test-dv-ne-02"
    resource_group_ref = "rg_test"
    cidr               = ["10.1.0.0/16"]
    subnets = {
      snet_app_02 = {
        name              = "snet-app"
        cidr              = ["10.1.0.128/25"]
        service_endpoints = ["Microsoft.Storage"]
      }
    }
  }
}
