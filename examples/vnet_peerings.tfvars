vnet_peerings = {
  peer_vnet_01_to_vnet_02_both = {
    vnet_left_ref  = "vnet_test_01"
    vnet_right_ref = "vnet_test_02"
    direction      = "<->"
  }
  peer_vnet_01_to_vnet_03_left_to_right = {
    vnet_left_ref  = "vnet_test_01"
    vnet_right_ref = "vnet_test_03"
    direction      = "->"
  }
  peer_vnet_01_to_vnet_03_right_to_left = {
    vnet_left_ref  = "vnet_test_02"
    vnet_right_ref = "vnet_test_03"
    direction      = "<-"
  }
}

# pre-requisites
resource_groups = {
  rg_test = {
    name     = "rg-test-networking-dv-ne-01"
    location = "northeurope"
  }
}

virtual_networks = {
  vnet_test_01 = {
    name               = "vnet-test-01"
    resource_group_ref = "rg_test"
    cidr               = ["10.120.0.0/24"]
  }
  vnet_test_02 = {
    name               = "vnet-test-02"
    resource_group_ref = "rg_test"
    cidr               = ["10.130.0.0/24"]
  }
  vnet_test_03 = {
    name               = "vnet-test-03"
    resource_group_ref = "rg_test"
    cidr               = ["10.140.0.0/24"]
  }
}
