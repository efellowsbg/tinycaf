module "load_balancers" {
  source   = "./modules/load_balancer"
  for_each = var.load_balancers

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "load_balancer_services" {
  source   = "./modules/load_balancer_service"
  for_each = var.load_balancer_services

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      load_balancers = module.load_balancers
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "load_balancer_targets" {
  source   = "./modules/load_balancer_target"
  for_each = var.load_balancer_targets

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      load_balancers = module.load_balancers
      servers        = module.servers
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "load_balancer_networks" {
  source   = "./modules/load_balancer_network"
  for_each = var.load_balancer_networks

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      load_balancers  = module.load_balancers
      networks        = module.networks
      network_subnets = module.network_subnets
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
