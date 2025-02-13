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
    }

    private_endpoint = {
      name       = "pe-acrtestdevne01"
      subnet_ref = "vnet_test/snet_private_endpoint_1"

      # This block is needed only if you need name different than the default
      private_service_connection = {
        name = "test-privateserviceconnection"
      }

      private_dns_zone_group_ref = "container_registries"
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

private_dns_zones = {
  container_registries = {
    resource_kind      = "container_registries"
    resource_group_ref = "rg_test"
    vnet_ref           = ["vnet_test"]
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
