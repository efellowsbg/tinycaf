virtual_machines = {
  machine_1 = {
    type               = "windows"
    name               = "vm-win-braytest-dv-ne-02"
    resource_group_ref = "rg_test"
    size               = "Standard_F2"
    admin_username     = "adminuser"
    admin_password     = "P@$$w0rd1234!"

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-Datacenter"
      version   = "latest"
    }

    network_interfaces = {
      nic_1 = {
        name = "test_nic_1"
        ip_configuration = {
          name       = "int-01"
          subnet_ref = "vnet_test/snet_app"
        }
      }

      nic_2 = {
        name = "test_nic_2"
        ip_configuration = {
          name       = "int-02"
          subnet_ref = "vnet_test/snet_app"
        }
      }
    }
  }

  machine_2 = {
    type               = "linux"
    name               = "vm-lin-braytest-dv-ne-02"
    resource_group_ref = "rg_test"
    size               = "Standard_F2"
    admin_username     = "adminuser"
    keyvault_ref       = "kv-test"

    network_interfaces = {
      nic_3 = {
        name = "test_nic_3"
        ip_configuration = {
          name                          = "int-03"
          subnet_ref                    = "vnet_test/snet_app"
          private_ip_address_allocation = "Dynamic"
        }
      }

      nic_4 = {
        name = "test_nic_4"
        ip_configuration = {
          name       = "int-04"
          subnet_ref = "vnet_test/snet_app"
        }
      }
    }

    public_key_openssh = {
      test_key_1 = {
        algorithm = "RSA"
        rsa_bits  = 4096
      }
    }

    admin_ssh_key = {
      username       = "adminuser"
      public_key_ref = "test_key_1"
    }

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
}


# pre-requisites
resource_groups = {
  rg_test = {
    name     = "rg-braytest-dv-ne-02"
    location = "northeurope"
  }
}

virtual_networks = {
  vnet_test = {
    name               = "vnet-test-dv-ne-01"
    resource_group_ref = "rg_test"
    cidr               = ["10.0.0.0/16"]
    subnets = {
      snet_app = {
        name              = "snet-test-dv-ne-01"
        cidr              = ["10.0.0.128/25"]
        service_endpoints = ["Microsoft.Storage"]
      }
    }
  }
}

keyvaults = {
  kv-test = {
    name               = "kv-braytest-dv-ne-02"
    resource_group_ref = "rg_test"

    secrets = {
      secret-test = {
        ignore_changes = false
      }
    }
  }
}
