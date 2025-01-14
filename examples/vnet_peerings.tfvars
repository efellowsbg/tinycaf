resource_groups = {
  vnets_ne = {
    name     = "rg-acfin-vnet-02"
    location = "North Europe"
  }
}


virtual_networks = {
  vnet_test = {
    name               = "vnet-test-01"
    resource_group_ref = "vnets_ne"
    cidr               = ["10.10.10.0/24"]
    subnets = {
      subnet1 = {
        name       = "sdajkhsda"
        cidr       = ["10.10.10.0/25"]
        delegation = "sql_managed_instance"
      }
      subnet2 = {
        name              = "iwoeuqiwe"
        cidr              = ["10.10.10.128/25"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
      }
    }
  }
  vnet_test2 = {
    name               = "vnet-test-02"
    resource_group_ref = "vnets_ne"
    cidr               = ["10.10.9.0/24"]
    subnets = {
      subnet1 = {
        name       = "sdajkhsda"
        cidr       = ["10.10.9.0/25"]
        delegation = "sql_managed_instance"
      }
      subnet2 = {
        name              = "iwoeuqiwe"
        cidr              = ["10.10.9.128/25"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
      }
    }
  }
}


vnet_peering = {
  peering = {
    vnet1_ref = "vnet_test"
    vnet2_ref = "vnet_test2"
    direction = "2to1"
  }
}
