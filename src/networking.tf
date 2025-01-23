module "virtual_networks" {
  source   = "./modules/_networking/virtual_network"
  for_each = var.virtual_networks

  settings        = each.value
  global_settings = var.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}

module "private_dns_zones" {
  source   = "./modules/_networking/private_dns_zone"
  for_each = var.private_dns_zones

  global_settings = var.global_settings
  settings        = each.value
  resources = {
    resource_groups  = module.resource_groups
    virtual_networks = module.virtual_networks
  }
}
