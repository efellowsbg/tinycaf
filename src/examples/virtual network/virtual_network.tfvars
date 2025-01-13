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
}
