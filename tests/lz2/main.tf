terraform {
  required_version = "~> 1.6.0"

  backend "local" {
    path = "../lz2.tfstate"
  }
}

module "tinycaf" {
  source = "../../src"

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

  config = {
    # TODO: find a way to enforce
    state_file = "lz2.tfstate"
    remote_states = {
      lz1 = {
        state_file = "../lz1.tfstate",
      }
    }
  }
}

output "objects" {
  value     = module.tinycaf.objects
  sensitive = true
}
