module "virtual_networks" {
  source   = "./modules/_networking/virtual_network"
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

module "public_ips" {
  source   = "./modules/_networking/public_ip"
  for_each = var.public_ips

  global_settings = var.global_settings
  settings        = each.value

  resources = {
    resource_groups = module.resource_groups
  }
}

module "virtual_network_gateways" {
  source   = "./modules/_networking/virtual_network_gateway"
  for_each = var.virtual_network_gateways

  global_settings = var.global_settings
  settings        = each.value

  resources = {
    virtual_networks = module.virtual_networks
    public_ips       = module.public_ips
    resource_groups  = module.resource_groups
  }
}

module "local_network_gateways" {
  source   = "./modules/_networking/local_network_gateway"
  for_each = var.local_network_gateways

  global_settings = var.global_settings
  settings        = each.value

  resources = {
    resource_groups = module.resource_groups
  }
}
