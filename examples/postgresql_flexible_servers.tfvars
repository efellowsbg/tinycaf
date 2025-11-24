postgresql_flexible_servers = {
  flex_postgres_server_test = {
    resource_group_ref     = "rg_test"
    name                   = "pg-flex-example"
    administrator_login    = "pgadmin"
    administrator_password = "SuperSecurePassword123!"
    sku_name               = "B_Standard_B1ms"
    version                = "14"
    zone                   = "1"

    storage_mb        = 32768
    storage_tier      = "P15"
    auto_grow_enabled = true

    backup_retention_days        = 7
    geo_redundant_backup_enabled = false

    public_network_access_enabled = false
    subnet_ref                    = "vnet_test/snet_sqlmi"
    dnszone_ref                   = "pdns_zone_test"

    identity = {
      type             = "SystemAssigned"
      identity_ids_ref = ["mi_test"]
    }

    authentication = {
      active_directory_auth_enabled = true
      password_auth_enabled         = true
    }

    customer_managed_key = {
      kvkey_ref = "kvkey_test1"
    }

    high_availability = {
      mode                      = "ZoneRedundant"
      standby_availability_zone = "2"
    }

    maintenance_window = {
      day_of_week  = 1
      start_hour   = 2
      start_minute = 30
    }
  }
}

# pre-requisites
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

private_dns_zones = {
  pdns_zone_test = {
    name               = "privatelink.postgres.database.azure.com"
    resource_group_ref = "rg_test"
    vnet_ref           = ["vnet_test"]
  }
}

managed_identities = {
  mi_test = {
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
          subnet_ref = "vnet_test/snet_private_endpoints"
        }
      }
    }
  }
}
