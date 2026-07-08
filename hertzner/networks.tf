module "networks" {
  source   = "./modules/network"
  for_each = var.networks

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "network_subnets" {
  source   = "./modules/network_subnet"
  for_each = var.network_subnets

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      networks = module.networks
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "network_routes" {
  source   = "./modules/network_route"
  for_each = var.network_routes

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      networks = module.networks
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
