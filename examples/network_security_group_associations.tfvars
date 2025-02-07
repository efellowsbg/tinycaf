network_security_group_associations = {
  nsg_association1 = {
    subnet_ref                 = "vnet_test/snet_private_endpoints1"
    network_security_group_ref = "nsg_test1"
  }
}

# pre-requisites
resource_groups = {
  rg_test = {
    name     = "rg-test-dv-ne-01"
    location = "northeurope"
  }
}

network_security_groups = {
  nsg_test1 = {
    name               = "testSecurityGroup1"
    resource_group_ref = "rg_test"

    security_rules = {
      sec_rule1 = {
        name                       = "testrule1_1"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
      sec_rule2 = {
        name                       = "testrule1_2"
        priority                   = 200
        direction                  = "Outbound"
        access                     = "Deny"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
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
