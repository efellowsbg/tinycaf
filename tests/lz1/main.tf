terraform {
  required_version = "~> 1.6.0"

  backend "local" {
    path = "../lz1.tfstate"
  }
}

module "tinycaf" {
  source = "../../src"
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
