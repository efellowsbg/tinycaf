private_endpoints = {
  pe_test1 = {
    name               = "pe-test1"
    resource_group_ref = "rg_test"
    subnet_ref         = "vnet_test1/snet_private_endpoints1"

    private_service_connection = {
      name                 = "psc-test1"
      is_manual_connection = false
      resource_type        = "storage_accounts"
      resource_ref         = "st_test1"
      subresource_names    = ["blob"]
    }

    private_dns_zone_group = {
      name                  = "pdns-test1"
      private_dns_zone_refs = ["storage_account_blob1"]
    }
  }

  pe_test2 = {
    name               = "pe-test2"
    resource_group_ref = "rg_test"
    subnet_ref         = "vnet_test2/snet_private_endpoints2"

    private_service_connection = {
      name                 = "psc-test2"
      is_manual_connection = false
      resource_type        = "storage_accounts"
      resource_ref         = "st_test2"
      subresource_names    = ["blob"]
    }

    private_dns_zone_group = {
      name                  = "pdns-test2"
      private_dns_zone_refs = ["storage_account_blob2"]
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
    name               = "dns-zone-1.blob.core.windows.net"
    resource_group_ref = "rg_test"
    vnet_ref           = ["vnet_test1"]
  }

  storage_account_blob2 = {
    name               = "dns-zone-2.blob.core.windows.net"
    resource_group_ref = "rg_test"
    vnet_ref           = ["vnet_test2"]
  }
}

storage_accounts = {
  st_test1 = {
    name                     = "sttestdvne01"
    resource_group_ref       = "rg_test"
    account_replication_type = "LRS"
  }

  st_test2 = {
    name                     = "sttestdvne02"
    resource_group_ref       = "rg_test"
    account_replication_type = "LRS"
  }
}

virtual_networks = {
  vnet_test1 = {
    name               = "vnet-test-dv-ne-01"
    resource_group_ref = "rg_test"
    cidr               = ["10.10.10.0/24"]
    subnets = {
      snet_private_endpoints1 = {
        name              = "snet-private-endpoints1"
        cidr              = ["10.10.10.128/27"]
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
        cidr              = ["20.20.20.160/27"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
      }
    }
  }
}
