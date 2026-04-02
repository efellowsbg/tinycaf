module "zones" {
  source   = "./modules/zone"
  for_each = var.zones

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "zone_records" {
  source   = "./modules/zone_record"
  for_each = var.zone_records

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      zones = module.zones
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "zone_rrsets" {
  source   = "./modules/zone_rrset"
  for_each = var.zone_rrsets

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      zones = module.zones
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
