bastion_hosts = {
  test_bastion = {
    name                      = "bastion-test"
    resource_group_ref        = "rg_test"
    copy_paste_enabled        = true
    file_copy_enabled         = true
    ip_connect_enabled        = true
    kerberos_enabled          = false
    shareable_link_enabled    = true
    tunneling_enabled         = true
    session_recording_enabled = false
    vnet_ref                  = "vnet_test_bastion"
    sku                       = "Standard"
    scale_units               = 2
    zones                     = ["1", "2", "3"]

    ip_configuration = {
      subnet_ref    = "vnet_test_bastion/snet_bastion"
      public_ip_ref = "pip_test_01"
    }
  }
}

# pre-requisites
public_ips = {
  pip_test_01 = {
    name               = "pip-test-dv-ne-01"
    resource_group_ref = "rg_test"
  }
}

resource_groups = {
  rg_test = {
    name     = "rg-test-01"
    location = "northeurope"
    tags = {
      DeployDate = "11/07/2025",
      DeadLine   = "11/07/2026",
      Owner      = "Test Test",
      Project    = "Test",
    }
  }
}

virtual_networks = {
  vnet_test = {
    name               = "vnet-test-dv-ne-01"
    resource_group_ref = "rg_test"
    cidr               = ["10.0.0.0/16"]
    subnets = {
      snet_app = {
        name              = "snet-app"
        cidr              = ["10.0.0.128/25"]
        service_endpoints = ["Microsoft.Storage"]
      }
    }
  }
  vnet_test_bastion = {
    name               = "vnet-test-bastion"
    resource_group_ref = "rg_test"
    cidr               = ["10.1.0.0/16"]
    subnets = {
      snet_bastion = {
        name = "AzureBastionSubnet"
        cidr = ["10.1.0.128/27"]
      }
    }
  }
}
