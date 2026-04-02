module "servers" {
  source   = "./modules/server"
  for_each = var.servers

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      networks         = module.networks
      firewalls        = module.firewalls
      placement_groups = module.placement_groups
      primary_ips      = module.primary_ips
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "server_networks" {
  source   = "./modules/server_network"
  for_each = var.server_networks

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      servers         = module.servers
      networks        = module.networks
      network_subnets = module.network_subnets
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
