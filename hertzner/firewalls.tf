module "firewalls" {
  source   = "./modules/firewall"
  for_each = var.firewalls

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "firewall_attachments" {
  source   = "./modules/firewall_attachment"
  for_each = var.firewall_attachments

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      firewalls = module.firewalls
      servers   = module.servers
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
