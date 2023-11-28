terraform {
  backend "local" {
    path = "../lz2.tfstate"
  }
}

module "tinycaf" {
  source = "../src"

  remote_states = {
    lz1 = "../lz1.tfstate",
    # lzx = "../lz1.tfstate",
  }
  state_ref = "lz2"
  managed_identities = {
    id_test_01 = {
      resource_group = {
        ref       = "rg_01"
        state_ref = "lz1"
      }
      name = "id-tinycaf-test-01"
    }
    id_test_02 = {
      resource_group_ref = "rg_02"
      name               = "id-tinycaf-test-02"
    }
    id_test_03 = {
      resource_group = {
        ref       = "rg_01"
        state_ref = "lz1"
      }
      name = "id-tinycaf-test-03"
    }
  }
  resource_groups = {
    rg_02 = {
      name     = "rg-tinycaf-test-02"
      location = "westeurope"
      tags = {
        "Owner"    = "drusev@efellows.bg"
        "DeadLine" = "2023-12-05"
        "Project"  = "tinycaf / eFellow Internal Infra"
      }
    }
  }
}

output "objects" {
  value     = module.tinycaf.objects
  sensitive = true
}
