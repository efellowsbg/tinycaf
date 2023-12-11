terraform {
  required_version = "~> 1.6.0"

  backend "local" {
    path = "../lz2.tfstate"
  }
}

module "tinycaf" {
  source = "../../src"

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
