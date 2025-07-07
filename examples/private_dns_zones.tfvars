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
    lz_key             = "sandbox"
    vnet_ref           = ["vnet_test", "vnet_test2"]
  }

  #Example for a remote vnet reference with a specific name
  acr = {
    resource_kind      = "container_registries"
    resource_group_ref = "rg_test"
    lz_key             = "sandbox"
    vnet_ref           = ["vnet_test/customname1", "vnet_test2/customname3"]
  }

  #Example for a remote vnet reference for a multiple landing zones with a specific name
  function_apps = {
    resource_kind      = "function_apps"
    resource_group_ref = "rg_test"
    remote_vnet_ref    = ["sandbox/vnet_test/customname1", "uat/vnet_test2/customname3"]
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
