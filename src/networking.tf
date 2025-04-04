module "virtual_networks" {
  source   = "./modules/_networking/virtual_network"
  for_each = var.virtual_networks

  settings        = each.value
  global_settings = local.global_settings
  ddos_id = ""
  resources = {
    resource_groups         = module.resource_groups
    network_security_groups = module.network_security_groups
  }
}



module "vnet_peerings" {
  source   = "./modules/_networking/vnet_peering"
  for_each = var.vnet_peerings

  settings        = each.value
  global_settings = local.global_settings

  resources = {
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
    resource_groups          = module.resource_groups
    virtual_networks         = module.virtual_networks
    keyvaults                = module.keyvaults
    local_network_gateways   = module.local_network_gateways
    virtual_network_gateways = module.virtual_network_gateways
  }
}

module "private_dns_a_records" {
  source   = "./modules/_networking/private_dns_a_record"
  for_each = var.private_dns_a_records

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups   = module.resource_groups
    private_dns_zones = module.private_dns_zones
  }
}

module "private_endpoints" {
  source   = "./modules/_networking/private_endpoint"
  for_each = var.private_endpoints

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups   = module.resource_groups
    virtual_networks  = module.virtual_networks
    private_dns_zones = module.private_dns_zones
    storage_accounts  = module.storage_accounts
  }
}

module "network_security_groups" {
  source   = "./modules/_networking/network_security_group"
  for_each = var.network_security_groups

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}

module "nat_gateways" {
  source   = "./modules/_networking/nat_gateway"
  for_each = var.nat_gateways

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}

module "network_security_group_associations" {
  source   = "./modules/_networking/network_security_group_association"
  for_each = var.network_security_group_associations

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups         = module.resource_groups
    network_security_groups = module.network_security_groups
    virtual_networks        = module.virtual_networks
  }
}
