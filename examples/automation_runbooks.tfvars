automation_runbooks = {
  test_runbook = {
    name                     = "runbooktest"
    acc_ref                  = "test_auto_acc"
    runbook_type             = "PowerShell"
    resource_group_ref       = "rg_test"
    log_progress             = true
    log_verbose              = true
    description              = "Daily cleanup of diagnostic logs older than 30 days."
    log_activity_trace_level = 9
    tags = {
      Env = "Test"
    }

    draft = {
      edit_mode_enabled = true
      output_types      = ["string"]

      content_link = {
        uri     = "https://raw.githubusercontent.com/org/repo/dev/runbooks/cleanup.ps1"
        version = "0.9.0"

        hash = {
          algorithm = "SHA256"
          value     = "B32E61E3D26D9C94D2AAFF5735C542A829E94C6C7BBCE83B7298C11B9F678ABC"
        }
      }

      parameters = {
        param_01 = {
          key           = "RetentionDays"
          type          = "Int"
          mandatory     = true
          position      = 1
          default_value = "30"
        }
        param_02 = {
          key           = "storageaccount"
          type          = "String"
          mandatory     = false
          position      = 2
          default_value = "mystorageacct"
        }
      }
    }
    publish_content_link = {
      uri     = "https://raw.githubusercontent.com/org/repo/main/runbooks/cleanup.ps1"
      version = "1.0.0"

      hash = {
        algorithm = "SHA256"
        value     = "C67F36DDA2AC0AAE7B44B69B7AA7BB22113E6543E0AD91A9A6DA27676B8D5A62"
      }
    }
    job_schedules = {
      daily = {
        schedule_name = "Dailymidnight"
        parameters = {
          RetentionDays = "30"
        }
      }

      weekly = {
        schedule_name = "weeklyreport"
        parameters = {
          RetentionDays  = "90"
          StorageAccount = "archivestorageacct"
        }
      }
    }
  }
}

# pre-requisites
automation_accounts = {
  test_auto_acc = {
    name                          = "automation-account-test"
    resource_group_ref            = "rg_test"
    local_authentication_enabled  = true
    public_network_access_enabled = true
    tags = {
      Env = "Test"
    }
    encryption = {
      key_ref = "kvkey_test1"
      mi_ref  = "id_test"
    }
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
          subnet_ref = "vnet_test/snet_private_endpoints"
        }
      }
    }
  }
}

managed_identities = {
  id_test = {
    name               = "id-test-dv-ne-01"
    resource_group_ref = "rg_test"
  }
}

virtual_networks = {
  vnet_test = {
    name               = "vnet-test-dv-ne-01"
    resource_group_ref = "rg_test"
    cidr               = ["10.10.10.0/24"]
    subnets = {
      snet_sqlmi = {
        name       = "snet-sql-managed-instance"
        cidr       = ["10.10.10.0/25"]
        delegation = "sql_managed_instance"
      }
      snet_private_endpoints = {
        name              = "snet-private-endpoints"
        cidr              = ["10.10.10.128/25"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
      }
    }
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
