private_endpoints = {
  pe_test1 = {
    name               = "example-endpoint1"
    resource_group_ref = "rg_test"
    subnet_ref         = "vnet_test/snet_private_endpoints1"

    private_service_connection = {
      name                 = "example-privateserviceconnection"
      is_manual_connection = false
      resource_type        = "storage_accounts"
      resource_ref         = "st_test"
    }

    private_dns_zone_group = {
      name                  = "example-privatednszone1"
      private_dns_zone_refs = ["storage_account_blob1", "storage_account_blob2"]
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
  storage_account_blob1 = {
    resource_kind      = "storage_blob"
    resource_group_ref = "rg_test"
    vnet_ref           = ["vnet_test"]
  }

  storage_account_blob2 = {
    resource_kind      = "storage_blob"
    resource_group_ref = "rg_test"
    vnet_ref           = ["vnet_test2"]
  }
}

storage_accounts = {
  st_test = {
    name                     = "sttestdvne01"
    resource_group_ref       = "rg_test"
    account_replication_type = "LRS"
  }
}

virtual_networks = {
  vnet_test = {
    name               = "vnet-test-dv-ne-01"
    resource_group_ref = "rg_test"
    cidr               = ["10.10.10.0/24"]
    subnets = {
      snet_private_endpoints1 = {
        name              = "snet-private-endpoints1"
        cidr              = ["10.10.10.10"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
      }
    }
  }

  vnet_test2 = {
    name               = "vnet-test-dv-ne-02"
    resource_group_ref = "rg_test"
    cidr               = ["20.20.20.0/24"]
    subnets = {
      snet_private_endpoints2 = {
        name              = "snet-private-endpoints2"
        cidr              = ["20.20.20.20"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
      }
    }
  }
}
