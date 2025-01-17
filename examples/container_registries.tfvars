container_registries = {
  acr_test_1 = {
    resource_group_ref = "rg_test"
    name               = "acrtestdevne01"
    sku                = "Premium"

    georeplications = {
      georeplication_test_1 = {
        location                = "West Europe"
        zone_redundancy_enabled = true
        tags                    = { Owner = "prod" }
      }
      georeplication_test_2 = {
        location                = "East US"
        zone_redundancy_enabled = true
      }
    }

    private_endpoint = {
      name       = "test-endpoint"
      subnet_ref = "vnet_test/snet_private_endpoint_1"
      private_service_connection = {
        name                 = "test-privateserviceconnection"
        is_manual_connection = true
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
    cidr               = ["10.10.10.0/24"]
    subnets = {
      snet_private_endpoint_1 = {
        name              = "snet-private-endpoint_1"
        cidr              = ["10.10.10.0/25"]
        service_endpoints = ["Microsoft.ContainerRegistry"]
      }
      snet_private_endpoint_2 = {
        name              = "snet-private-endpoint_2"
        cidr              = ["10.10.10.128/25"]
        service_endpoints = ["Microsoft.ContainerRegistry"]
      }
    }
  }
}
