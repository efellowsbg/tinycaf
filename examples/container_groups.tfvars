container_groups = {
  container_gr_test1 = {
    name               = "test-continst1"
    resource_group_ref = "rg_test"
    ip_address_type    = "Public"
    os_type            = "Linux"
    key_vault_key_ref  = "kvkey_test1"

    containers = {
      container_test1 = {
        name   = "hello-world"
        image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
        cpu    = "0.5"
        memory = "1.5"

        secure_environment_variables = {
          "SECENV1" = "value-sec-env1"
          "SECENV2" = "value-sec-env2"
        }

        ports = {
          port_hhtps = {
            port     = "443"
            protocol = "TCP"
          }
          port_hhtp = {
            port     = "80"
            protocol = "TCP"
          }
        }
      }

      container_test2 = {
        name   = "sidecar"
        image  = "mcr.microsoft.com/azuredocs/aci-tutorial-sidecar"
        cpu    = "0.5"
        memory = "1.5"

        environment_variables = {
          "ENV1" = "value-env1"
          "ENV2" = "value-env2"
        }
      }
    }

    dns_config = {
      nameservers = ["10.10.10.10", "20.20.20.20"]
    }

    diagnostics = {
      log_analitics = {
        workspace_ref = "log_workspace_test1"
        log_type      = "ContainerInsights"
        metadata = {
          environment = "staging"
          owner       = "devops-team"
        }
      }
    }

    exposed_ports = {
      exp_port1 = {
        port     = "8080"
        protocol = "UDP"
      }
      exp_port2 = {
        port     = "8443"
        protocol = "UDP"
      }
    }

    image_registry_credentials = {
      cred1 = {
        server   = "anotherprivateregistry.azurecr.io"
        username = "another-username"
        password = "another-password"
      }
      cred2 = {
        server   = "myprivateregistry.azurecr.io"
        username = "my-username"
        password = "my-password"
      }
    }

    identity = {
      type             = "SystemAssigned, UserAssigned"
      identity_ids_ref = ["id_test"]
    }

    timeouts = {
      read = "6m"
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

log_analytics_workspaces = {
  log_workspace_test1 = {
    name               = "law-test-01"
    resource_group_ref = "rg_test"

    identity = {
      type = "SystemAssigned"
    }
  }
}

managed_identities = {
  id_test = {
    name               = "id-test-dv-ne-01"
    resource_group_ref = "rg_test"
  }
}

key_vault_keys = {
  kvkey_test1 = {
    name          = "generated-certificate"
    key_vault_ref = "kv_test"
    key_type      = "RSA"
    key_size      = "2048"

    key_opts = [
      "decrypt",
      "encrypt",
      "sign",
      "unwrapKey",
      "verify",
      "wrapKey",
    ]

    rotation_policy = {
      expire_after         = "P90D"
      notify_before_expiry = "P29D"
      automatic = {
        time_before_expiry = "P30D"
      }
    }
  }
}

keyvaults = {
  kv_test = {
    name               = "kv-test-dv-ne-01"
    resource_group_ref = "rg_test"
    network_rules = {
      default_action = "Deny"
      allowed_ips    = ["10.10.10.10", "20.20.20.20"]
      subnets = {
        allow_app1 = {
          subnet_ref = "vnet_test/snet_app1"
        }
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
      snet_app1 = {
        name              = "snet-private-endpoints"
        cidr              = ["10.10.10.128/25"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
      }
    }
  }
}
