container_groups = {
  container_gr_test1 = {
    name               = "test-continst1"
    resource_group_ref = "rg_test"
    ip_address_type    = "Public"
    os_type            = "Linux"

    container = {
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
          port     = 443
          protocol = "TCP"
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

    diagnostics = {
      log_analitics_1 = {
        workspace_ref = "log_workspace_test1"
      }
    }

    identity = {
      type = "SystemAssigned"
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
    name   = "id-test-dv-ne-01"
    rg_ref = "rg_test"
  }
}
