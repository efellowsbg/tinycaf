keyvaults = {
  kv-acfin-01 = {
    name                          = "kv-acfin-ne-01"
    resource_group_ref            = "acfin2"
    public_network_access_enabled = true
    network_rules = {
      default_action = "Allow"
      allowed_ips    = ["95.43.223.55"]
      subnets = {
        subnet1 = {
          subnet_ref = "vnet_acfin_prod_01/sn-resources"
        }
      }
    }
    access_policies = {
      managed_identity = {
        managed_identity_refs = ["id_acfin_01"]
        secret_permissions    = "All"
        key_permissions       = ["Get", "List"]
      }
      logged_in_user = {
        secret_permissions = "All"
        key_permissions    = "All"
      }
      object_ids = {
        object_ids         = ["7c265d5c-6e52-4a53-b3a9-90c663567c64"]
        secret_permissions = "All"
        key_permissions    = "All"
      }
    }
    secrets = {
      secret-skey = {
        name           = "SharedKey"
        value          = "default"
        ignore_changes = true
      }
    }
  }
}


# pre-requisites
virtual_networks = {
  vnet_test = {
    name               = "vnet-test-dv-ne-01"
    resource_group_ref = "rg_test"
    cidr               = ["10.10.10.0/24"]
    subnets = {
      snet_sqlmi = {
        name = "snet-app1"
        cidr = ["10.10.10.0/25"]
      }
      snet_private_endpoints = {
        name              = "snet-private-endpoints"
        cidr              = ["10.10.10.128/25"]
        service_endpoints = ["Microsoft.KeyVault"]
      }
    }
  }
}

resource_groups = {
  rg_test = {
    name     = "rg-test-dv-ne-01"
    location = "northeurope"
  }
}
