module "primary_ips" {
  source   = "./modules/primary_ip"
  for_each = var.primary_ips

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "floating_ips" {
  source   = "./modules/floating_ip"
  for_each = var.floating_ips

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "floating_ip_assignments" {
  source   = "./modules/floating_ip_assignment"
  for_each = var.floating_ip_assignments

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      floating_ips = module.floating_ips
      servers      = module.servers
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "rdns_records" {
  source   = "./modules/rdns"
  for_each = var.rdns_records

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      servers        = module.servers
      primary_ips    = module.primary_ips
      floating_ips   = module.floating_ips
      load_balancers = module.load_balancers
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
