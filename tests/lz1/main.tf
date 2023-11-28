terraform {
  required_version = "~> 1.6.0"

  backend "local" {
    path = "../lz1.tfstate"
  }
}

module "tinycaf" {
  source = "../../src"
  resource_groups = {
    rg_01 = {
      name     = "rg-tinycaf-test-01"
      location = "westeurope"
      tags = {
        "Owner"    = "drusev@efellows.bg"
        "DeadLine" = "2023-12-05"
        "Project"  = "tinycaf / eFellow Internal Infra"
      }
    }
  }
  config = {
    # no container definitions means use local
    state_file = "lz1.tfstate"
    # TODO: workspaces
  }
}

output "objects" {
  value     = module.tinycaf.objects
  sensitive = true
}
