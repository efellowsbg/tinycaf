private_dns_zones = {
  storage_account_blob = {
    resource_kind      = "storage_blob"
    resource_group_ref = "rg_test"
    vnet_ref           = ["vnet_test", "vnet_test2"]
  }

  #Example for a remote vnet reference
  acr = {
    resource_kind      = "container_registries"
    resource_group_ref = "rg_test"
    vnet_links = {
      link1 = {
        vnet_ref = "vnet_test"
        name     = "custom_name1"
      }
      link2 = {
        vnet_ref = "vnet_test2"
      }
      link2 = {
        lz_key   = "sandbox"
        vnet_ref = "vnet_test2"
        name     = "custom_name2"
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
