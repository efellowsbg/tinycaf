module "volumes" {
  source   = "./modules/volume"
  for_each = var.volumes

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      servers = module.servers
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "volume_attachments" {
  source   = "./modules/volume_attachment"
  for_each = var.volume_attachments

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      volumes = module.volumes
      servers = module.servers
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
