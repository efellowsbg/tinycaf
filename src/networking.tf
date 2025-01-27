module "virtual_networks" {
  source   = "./modules/_networking/virtual_network"
  for_each = var.virtual_networks

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}

module "private_dns_zones" {
  source   = "./modules/_networking/private_dns_zone"
  for_each = var.private_dns_zones

  global_settings = local.global_settings
  settings        = each.value
  resources = {
    resource_groups  = module.resource_groups
    virtual_networks = module.virtual_networks
  }
}

module "virtual_network_gateways" {
  source   = "./modules/_networking/virtual_network_gateway"
  for_each = var.virtual_network_gateways

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    virtual_networks = module.virtual_networks
    public_ips       = module.public_ips
    resource_groups  = module.resource_groups
  }
}

module "public_ips" {
  source   = "./modules/_networking/public_ip"
  for_each = var.public_ips

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
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

module "virtual_network_gateway_connections" {
  source   = "./modules/_networking/virtual_network_gateway_connections"
  for_each = var.virtual_network_gateway_connections

  global_settings = var.global_settings
  settings        = each.value
  resources = {
    resource_groups        = module.resource_groups
    virtual_networks       = module.virtual_networks
    keyvaults              = module.keyvaults
    local_network_gateways = module.local_network_gateways
  }
}
