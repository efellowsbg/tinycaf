module "container_registries" {
  source   = "./modules/container_registries"
  for_each = var.container_registries

  settings        = each.value
  global_settings = var.global_settings

  resources = {
    resource_groups  = module.resource_groups
    virtual_networks = module.virtual_networks
  }
}
