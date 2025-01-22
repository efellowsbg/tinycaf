module "virtual_networks" {
  source   = "./modules/_networking/virtual_network"
  for_each = var.virtual_networks

  settings        = each.value
  global_settings = var.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}
