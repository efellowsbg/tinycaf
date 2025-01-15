virtual_network_gateways = {
  gw_vpn_01 = {
    name               = "gw-01-test"
    resource_group_ref = "rg_test"
    generation         = "Generation1"
    ip_configurations = {
      conf_01 = {
        name                          = "test_01"
        private_ip_address_allocation = "Static"
        vnet_ref                      = "vnet_test"
        subnet_ref                    = "subnet1"
        public_ip_address_ref         = "pub_ip_test_1"
      }
      conf_02 = {
        name                          = "test_02"
        private_ip_address_allocation = "Static"
        vnet_ref                      = "vnet_test"
        subnet_ref                    = "subnet2"
        public_ip_address_ref         = "pub_ip_test_1"
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
      snet_sqlmi = {
        name = "snet-sql-managed-instance"
        cidr = ["10.10.10.0/25"]
      }
      snet_private_endpoints = {
        name = "snet-private-endpoints"
        cidr = ["10.10.10.128/25"]
      }
    }
  }
}

public_ips = {
  pub_ip_test_1 = {
    name               = "pub-ip-test-01"
    resource_group_ref = "vnets_ne"
  }
}
