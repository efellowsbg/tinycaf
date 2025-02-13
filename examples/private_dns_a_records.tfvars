private_dns_a_records = {
  dns_a_record1 = {
    name               = "test-private-dns-a-record1"
    zone_ref           = "storage_account_blob1"
    resource_group_ref = "rg_test"
    ttl                = "300"
    records            = ["10.0.180.17"]
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
}

virtual_networks = {
  vnet_test = {
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
}
