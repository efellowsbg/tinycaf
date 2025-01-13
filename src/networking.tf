module "virtual_networks" {
  source   = "./modules/_networking/virtual_networks"
  for_each = var.virtual_networks

  settings        = each.value
  global_settings = var.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}


module "vnet_peering" {
  source = "./modules/_networking/virtual_networks"
  for_each = var.vnet_peering
  global_settings = var.global_settings
  settings = each.value
  resources = {
    virtual_networks = module.virtual_networks
  }
}