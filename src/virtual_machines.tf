module "virtual_machines" {
  source = "./modules/virtual_machines"
  # for_each = var.virtual_machines

  settings        = var.virtual_machines
  global_settings = var.global_settings

  resources = {
    resource_groups  = module.resource_groups
    virtual_networks = module.virtual_networks
  }
}
