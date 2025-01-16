virtual_network_gateways = {
  vng_test_01 = {
    name               = "vng-test-dv-ne-01"
    resource_group_ref = "rg_test"

    # generation = "Generation1" # defaults to None
    # sku        = "Basic"

    ip_configurations = {
      conf_01 = {
        name = "default"

        subnet_ref            = "vnet_test/snet_vng" # !! subnet must be named GatewaySubnet !!
        public_ip_address_ref = "pip_test_01"
      }
      # conf_02 = {
      #   name                          = "conf-02"
      #   private_ip_address_allocation = "Static" # defaults to Dynamic

      #   subnet_ref            = "vnet_test/snet_vng"
      #   public_ip_address_ref = "pip_test_01"
      # }
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
      snet_vng = {
        name = "GatewaySubnet"
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
  pip_test_01 = {
    name               = "pip-test-dv-ne-01"
    resource_group_ref = "rg_test"
  }
}
