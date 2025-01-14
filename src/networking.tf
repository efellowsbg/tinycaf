module "virtual_networks" {
  source   = "./modules/_networking/virtual_networks"
  for_each = var.virtual_networks

  settings        = each.value
  global_settings = var.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}

module "vnet_peerings" {
  source   = "./modules/_networking/vnet_peering"
  for_each = var.vnet_peerings

  global_settings = var.global_settings
  settings        = each.value

  resources = {
    virtual_networks = module.virtual_networks
  }
}

module "vnet_gateways" {
  source   = "./modules/_networking/virtual_network_gateways"
  for_each = var.virtual_network_gateways

  global_settings = var.global_settings
  settings        = each.value

  resources = {
    virtual_networks = module.virtual_networks
    public_ips       = module.public_ips
    resource_groups  = module.public_ips
  }
}

module "public_ips" {
  source   = "./modules/_networking/public_ips"
  for_each = var.public_ips

  global_settings = var.global_settings
  settings        = each.value

  resources = {
    resource_groups = module.resource_groups
  }
}
