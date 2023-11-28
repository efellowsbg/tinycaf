terraform {
  backend "local" {
    path = "../lz1.tfstate"
  }
}

module "tinycaf" {
  source = "../src"
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
  state_ref = "lz1"
}

output "objects" {
  value     = module.tinycaf.objects
  sensitive = true
}
